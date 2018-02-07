BUILD:=build
SRC:=src
INC:=inc
LIB:=lib

all: hello

runtest: test
	./test

test: $(BUILD)/test.o $(BUILD)/testfun.o
	g++ $^ -o $@

hello: main
	mv main hello
	
main: $(BUILD)/main.o $(BUILD)/testfun.o $(LIB)/libcall.a
	g++ -L$(LIB) $^ -o $@

lib: $(LIB)/lib.a

$(LIB)/libcall.a: $(BUILD)/libcall.o
	ar rcs $@ $^

# check out implicit rules and automatic variables
$(BUILD)/%.o: $(BUILD)/%.S
	g++ -c $< -o $@

$(BUILD)/%.S: $(BUILD)/%.cc
	g++ -S $< -o $@

$(BUILD)/%.cc: $(SRC)/%.cpp $(INC)/testfun.hpp $(INC)/libcall.hpp
	g++ -E $< -I$(INC) -o $@

clean:
	-rm test hello $(BUILD)/*.cc $(BUILD)/*.S $(BUILD)/*.o

cleanall: clean
	-rm $(LIB)/*.a

.PHONY: clean
# preserve all intermediate files created by implicit rules above
.PRECIOUS: $(BUILD)/%.cc $(BUILD)/%.S
