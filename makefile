BUILD:=build
SRC:=src
INC:=inc

all: hello

hello: main
	mv main hello
	
main: $(BUILD)/main.o $(BUILD)/testfun.o
	g++ $^ -o $@

# check out implicit rules and automatic variables
$(BUILD)/%.o: $(BUILD)/%.S
	g++ -c $< -o $@

$(BUILD)/%.S: $(BUILD)/%.cc
	g++ -S $< -o $@

$(BUILD)/%.cc: $(SRC)/%.cpp $(INC)/testfun.hpp
	g++ -E $< -I$(INC) -o $@

clean:
	-rm hello $(BUILD)/*.cc $(BUILD)/*.S $(BUILD)/*.o

.PHONY: clean
# preserve all intermediate files created by implicit rules above
.PRECIOUS: $(BUILD)/%.cc $(BUILD)/%.S
