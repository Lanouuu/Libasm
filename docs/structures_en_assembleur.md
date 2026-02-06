# Guide des Structures en Assembleur (NASM 64-bit)

Ce guide détaille l'utilisation des structures en assembleur NASM pour l'architecture Intel 64-bit.

---

## 1. Le Concept de Structure en Assembleur

En assembleur, une **structure** n'est pas un type de donnée natif comme en C. Il s'agit d'une **convention** pour traiter un bloc de mémoire contigu comme un ensemble de champs (ou membres). NASM fournit des directives pour simplifier cette gestion.

---

## 2. Définir un Modèle de Structure (`struc`)

Pour créer un "plan" de structure, on utilise les directives `struc` et `endstruc`. Cette étape ne réserve aucune mémoire.

À l'intérieur, on déclare les membres et leur taille avec les directives de réservation (`resb`, `resw`, `resd`, `resq`).

### Exemple : Une structure `Point`

```assembly
; Définition du modèle pour un point 2D
struc Point
    .x: resq 1  ; Coordonnée X (entier de 64 bits)
    .y: resq 1  ; Coordonnée Y (entier de 64 bits)
    .size:      ; Étiquette spéciale pour la taille totale
endstruc
```

**Points clés :**
-   Les étiquettes commençant par un point (`.x`, `.y`) sont locales à la structure.
-   NASM calcule automatiquement les **décalages (offsets)** de chaque membre :
    -   `.x` est à l'offset `0`.
    -   `.y` est à l'offset `8`.
-   L'étiquette `.size` est une convention utile : NASM lui assigne la taille totale de la structure (ici, `16` octets).

---

## 3. Créer une Instance d'une Structure

"Instancier" une structure signifie réserver de la mémoire pour elle, en se basant sur le modèle défini.

### a) Dans la section `.data` (Données Initialisées)

Pour créer une instance et initialiser ses champs.

```assembly
section .data
    ; Instance de Point, nommée my_point
    my_point:
        istruc Point
            at .x, dq 10   ; Initialise le membre 'x' avec la valeur 10
            at .y, dq -5   ; Initialise le membre 'y' avec la valeur -5
        iend
```
-   On utilise le couple `istruc` / `iend`.
-   La directive `at` permet de spécifier la valeur initiale d'un membre.

### b) Dans la section `.bss` (Données Non Initialisées)

Pour réserver l'espace mémoire sans l'initialiser.

```assembly
section .bss
    ; Instance de Point, nommée another_point
    another_point:
        resb Point.size  ; Réserve 16 octets (la taille de la structure Point)
```

---

## 4. Accéder aux Membres d'une Structure

C'est l'opération la plus courante. La formule est :

`adresse du membre = adresse de base de l'instance + décalage du membre`

### Exemple : Manipulation d'une instance

```assembly
section .text
global _start

_start:
    ; 1. Charger l'adresse de base de l'instance dans un registre
    mov rbx, another_point

    ; 2. Écrire dans les membres de la structure
    ; another_point.x = 100
    mov qword [rbx + Point.x], 100

    ; another_point.y = 200
    mov qword [rbx + Point.y], 200

    ; 3. Lire un membre de la structure
    ; rax = another_point.x
    mov rax, [rbx + Point.x]

    ; ... fin du programme
    mov rax, 60
    xor rdi, rdi
    syscall
```

**Explications :**
-   `Point.x` et `Point.y` sont remplacés par l'assembleur par leurs valeurs numériques (`0` et `8`). Utiliser les noms rend le code bien plus lisible.
-   `qword` est crucial : il spécifie que l'on manipule une donnée de 64 bits (8 octets), correspondant à la taille de nos membres (`resq`).

---

## 5. Cas d'Usage : Pointeur vers une Structure

Il est très fréquent de passer un **pointeur** vers une structure à une fonction. Selon la convention d'appel 64-bit, le premier argument est passé via le registre `rdi`.

### Exemple : Une fonction modifiant un `Point`

```assembly
; Convention d'appel :
; rdi = pointeur vers une structure Point
; rsi = nouvelle valeur pour x
set_point_x:
    ; rdi contient déjà l'adresse de base
    mov qword [rdi + Point.x], rsi
    ret
```
Le code est concis car `rdi` agit déjà comme notre registre de base.

---

## 6. Architecture Mémoire d'une Structure

Comprendre comment une structure est organisée en mémoire est essentiel.

### a. Contiguïté et Ordre

Les membres d'une structure sont placés **les uns après les autres en mémoire**, dans l'ordre où ils sont déclarés. Il n'y a pas de "trous" entre eux, sauf pour des raisons d'alignement (un sujet plus avancé).

Pour notre structure `Point`:
- Le premier octet de la mémoire allouée pour une instance de `Point` est le premier octet du membre `.x`.
- Le membre `.y` commence immédiatement après la fin du membre `.x`.

### b. Visualisation de la Mémoire

Imaginons une instance de `Point` située à l'adresse `0x1000`. Voici à quoi ressemblerait la mémoire :

```
Adresse Mémoire | Décalage | Membre  | Contenu
----------------|----------|---------|-------------------------
0x1000          | +0       | Point.x | 8 octets pour la coord. X
0x1008          | +8       | Point.y | 8 octets pour la coord. Y
0x1010          | +16      |         | (Fin de la structure)
```

- **Adresse de base** : `0x1000`
- **Adresse de `Point.y`** : `Adresse de base + décalage de .y` -> `0x1000 + 8` = `0x1008`.

C'est cette disposition prévisible qui nous permet d'utiliser la formule `[registre_base + décalage]` pour accéder à n'importe quel membre de manière fiable. La structure est essentiellement une "grille" posée sur un bloc de mémoire.

### c. Alignement et Padding (Sujet Avancé)

Parfois, il peut y avoir des "trous" dans une structure. C'est ce qu'on appelle le **padding** (rembourrage), et il est lié à l'**alignement mémoire**.

- **Le Problème :** Les processeurs (CPU) lisent la mémoire plus efficacement lorsque les données sont "alignées". Une donnée est alignée si son adresse en mémoire est un multiple de sa taille.
    - Un `word` (2 octets) est aligné à une adresse multiple de 2.
    - Un `dword` (4 octets) est aligné à une adresse multiple de 4.
    - Un `qword` (8 octets) est aligné à une adresse multiple de 8.
- **La Pénalité :** Sur l'architecture x86-64, un accès non aligné est plus lent, car le CPU doit effectuer deux lectures mémoire au lieu d'une seule pour récupérer la donnée. Sur d'autres architectures (comme ARM), cela peut même provoquer un crash.
- **La Solution :** Pour garantir la performance, les compilateurs et les assembleurs insèrent des octets de remplissage (padding) pour s'assurer que chaque membre de la structure commence à une adresse alignée.

**Exemple de Padding :**

Considérons cette structure :
```assembly
struc MisalignedStruct
    .a: resb 1  ; 1 octet
    .b: resq 1  ; 8 octets
endstruc
```

Si une instance de cette structure commence à l'adresse `0x1000` :
- Le membre `.a` serait à `0x1000`.
- Sans padding, le membre `.b` commencerait à `0x1001`, ce qui n'est pas un multiple de 8. Ce serait un accès non aligné.

Pour corriger cela, 7 octets de padding sont insérés après `.a`. La structure en mémoire ressemblerait à ceci :

```
Adresse Mémoire | Décalage | Contenu
----------------|----------|--------------------------------
0x1000          | +0       | Membre .a (1 octet)
0x1001          | +1       | Padding (7 octets inutilisés)
0x1008          | +8       | Membre .b (8 octets)
0x1010          | +16      | (Fin de la structure)
```
La taille totale de la structure devient 16 octets au lieu de 9. Le membre `.b` est maintenant aligné, garantissant un accès rapide.

NASM ne fait pas de padding automatiquement avec `struc`, mais c'est un comportement standard des compilateurs C, et il est crucial de le savoir lorsque l'on écrit de l'assembleur qui doit interagir avec du code C.

---

## Résumé et Bonnes Pratiques

1.  **Définir (`struc`)** : Créez un plan clair pour vos données.
2.  **Instancier (`istruc` ou `resb`)** : Réservez la mémoire dans `.data` ou `.bss`.
3.  **Accéder** : Chargez l'adresse de base de l'instance dans un registre, puis utilisez les décalages pour lire/écrire (`[base_reg + Struct.member]`).
4.  **Lisibilité** : Privilégiez toujours les noms de membres (`Point.x`) aux décalages en dur (`0`, `8`).
5.  **Taille des données** : Utilisez `byte`, `word`, `dword`, `qword` pour spécifier la taille des données que vous manipulez, afin d'éviter les erreurs.
