FLAGS = -static -Wall

all:
	cyc $(FLAGS) -o weakdes weakdes.curry
