NAME			=	libasm.a

NAME_BONUS		=	libasm_bonus.a

AS				=	nasm

ASFLAGS			=	-f elf64

# **************************************************************************** #
#                                                                              #
#                                  COLORS                                      #
#                                                                              #
# **************************************************************************** #

COLOUR_GREEN	=	\033[0;32m

YELLOW			=	\033[0;33m

COLOUR_END		=	\033[0m

# **************************************************************************** #
#                                                                              #
#                                  SOURCES                                     #
#                                                                              #
# **************************************************************************** #

SOURCES_PATH 		=	src/

SOURCES_PATH_BONUS	=	src_bonus/

SOURCES				=	ft_strlen.s \
						ft_strcmp.s \
						ft_strcpy.s \
						ft_write.s \
						ft_read.s \
						ft_strdup.s \

SOURCES_BONUS		=	ft_atoi_base_bonus.s \
						ft_list_push_front_bonus.s \

# **************************************************************************** #
#                                                                              #
#                                  OBJECTS                                     #
#                                                                              #
# **************************************************************************** #

OBJECTS_PATH		=	objs/

OBJECTS_PATH_BONUS	=	objs_bonus/

OBJECTS				=	$(addprefix ${OBJECTS_PATH}, ${SOURCES:.s=.o}) \

OBJECTS_BONUS		=	$(addprefix ${OBJECTS_PATH_BONUS}, ${SOURCES_BONUS:.s=.o}) \

# **************************************************************************** #
#                                                                              #
#                                  RULES                                       #
#                                                                              #
# **************************************************************************** #

all: ${NAME}

${NAME} : ${OBJECTS}
	@ar -rcs ${NAME} ${OBJECTS}
	@echo "${COLOUR_GREEN}\33[2K\nLibasm compiled\n${COLOUR_END}"

${NAME_BONUS} : ${OBJECTS_BONUS}
	@ar -rcs ${NAME_BONUS} ${OBJECTS_BONUS}
	@echo "${COLOUR_GREEN}\33[2K\nLibasm bonus compiled\n${COLOUR_END}"

${OBJECTS_PATH}%.o:	${SOURCES_PATH}%.s
	@mkdir -p ${OBJECTS_PATH}
	@${AS} ${ASFLAGS} $< -o $@ && printf "\33[2K\r${YELLOW}Compiling Libasm :${COLOUR_END} $@" 

${OBJECTS_PATH_BONUS}%.o : ${SOURCES_PATH_BONUS}%.s
	@mkdir -p ${OBJECTS_PATH_BONUS}
	@${AS} ${ASFLAGS} $< -o $@ && printf "\33[2K\r${YELLOW}Compiling Libasm bonus :${COLOUR_END} $@" 

clean: 
	@rm -rf ${OBJECTS_PATH}
	@rm -rf ${OBJECTS_PATH_BONUS}

fclean: 
	@rm -rf ${NAME} ${NAME_BONUS} ${OBJECTS_PATH} ${OBJECTS_PATH_BONUS}
	@rm -rf mandatory bonus
	@echo "${COLOUR_GREEN}libasm cleaned\n${COLOUR_END}"

re: fclean all

ret: fclean test

retb: fclean testb

bonus: ${NAME_BONUS}

test: $(NAME) main.c
	@cc -Wall -Wextra -Werror main.c libasm.a -o mandatory

testb: ${NAME_BONUS} main_bonus.c
	@cc -Wall -Wextra -Werror main_bonus.c libasm_bonus.a -o bonus

.PHONY: fclean clean all re