BUILD:=build

all: hello
	
hello: $(BUILD)/hello.o $(BUILD)/testfun.o
	g++ $(BUILD)/hello.o $(BUILD)/testfun.o -o hello

$(BUILD)/hello.o: $(BUILD)/hello.S
	g++ -c $(BUILD)/hello.S -o $(BUILD)/hello.o

$(BUILD)/hello.S: $(BUILD)/hello.cc
	g++ -S $(BUILD)/hello.cc -o $(BUILD)/hello.S

$(BUILD)/hello.cc: main.cpp testfun.hpp
	g++ -E main.cpp -o $(BUILD)/hello.cc

$(BUILD)/testfun.o: $(BUILD)/testfun.S
	g++ -c $(BUILD)/testfun.S -o $(BUILD)/testfun.o

$(BUILD)/testfun.S: $(BUILD)/testfun.cc
	g++ -S $(BUILD)/testfun.cc -o $(BUILD)/testfun.S

$(BUILD)/testfun.cc: testfun.cpp testfun.hpp
	g++ -E testfun.cpp -o $(BUILD)/testfun.cc

clean:
	-rm hello $(BUILD)/*.cc $(BUILD)/*.S $(BUILD)/*.o

.PHONY: clean
