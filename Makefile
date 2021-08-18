all: ent pack pr testu

ent:
	./scripts/build_ent.sh

pack:
	gcc -o pack scripts/pack.c

pr:
	./scripts/build_pr.sh

testu:
	./scripts/build_testu.sh

.PHONY: clean
clean:
	rm -f ent pack pr testu