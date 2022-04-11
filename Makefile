all: ent pack pr testu lfsr32

ent:
	./scripts/build_ent.sh

pack:
	gcc -o pack scripts/pack.c

pr:
	./scripts/build_pr.sh

testu:
	./scripts/build_testu.sh

lfsr32:
	gcc -o lfsr32 ./scripts/lfsr32.c

.PHONY: clean
clean:
	rm -f ent pack pr testu lfsr32
