NAME			=	libasm.a

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

SOURCES_PATH 	= src/

SOURCES			=	ft_strlen.s \
					ft_strcmp.s \
					ft_strcpy.s \

# **************************************************************************** #
#                                                                              #
#                                  OBJECTS                                     #
#                                                                              #
# **************************************************************************** #

OBJECTS_PATH	=	objs/

OBJECTS			=	$(addprefix ${OBJECTS_PATH}, ${SOURCES:.s=.o}) \

# **************************************************************************** #
#                                                                              #
#                                  RULES                                       #
#                                                                              #
# **************************************************************************** #

all: ${NAME}

${NAME} : ${OBJECTS}
	@ar -rcs ${NAME} ${OBJECTS}
	@echo "${COLOUR_GREEN}\33[2K\nLibasm compiled\n${COLOUR_END}"

${OBJECTS_PATH}%.o:	${SOURCES_PATH}%.s
	@mkdir -p ${OBJECTS_PATH}
	@${AS} ${ASFLAGS} $< -o $@ && printf "\33[2K\r${YELLOW}Compiling Libasm :${COLOUR_END} $@" 

clean: 
	@rm -rf ${OBJECTS_PATH}

fclean: 
	@rm -rf libasm.a ${OBJECTS_PATH}
	@rm a.out
	@echo "${COLOUR_GREEN}libasm cleaned\n${COLOUR_END}"

re: fclean all

.PHONY: fclean clean all re