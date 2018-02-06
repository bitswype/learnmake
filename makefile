BUILD:=build
SRC:=src
INC:=inc

all: hello
	
hello: $(BUILD)/hello.o $(BUILD)/testfun.o
	g++ $(BUILD)/hello.o $(BUILD)/testfun.o -o hello

$(BUILD)/hello.o: $(BUILD)/hello.S
	g++ -c $(BUILD)/hello.S -o $(BUILD)/hello.o

$(BUILD)/hello.S: $(BUILD)/hello.cc
	g++ -S $(BUILD)/hello.cc -o $(BUILD)/hello.S

$(BUILD)/hello.cc: $(SRC)/main.cpp $(INC)/testfun.hpp
	g++ -E $(SRC)/main.cpp -I$(INC) -o $(BUILD)/hello.cc

$(BUILD)/testfun.o: $(BUILD)/testfun.S
	g++ -c $(BUILD)/testfun.S -o $(BUILD)/testfun.o

$(BUILD)/testfun.S: $(BUILD)/testfun.cc
	g++ -S $(BUILD)/testfun.cc -o $(BUILD)/testfun.S

$(BUILD)/testfun.cc: $(SRC)/testfun.cpp $(INC)/testfun.hpp
	g++ -E $(SRC)/testfun.cpp -I$(INC) -o $(BUILD)/testfun.cc

clean:
	-rm hello $(BUILD)/*.cc $(BUILD)/*.S $(BUILD)/*.o

.PHONY: clean
