NEXTDIR = tmp

source = libstack.a

.PHONY: all
all:
	@echo "Entering $(NEXTDIR)"
	make -C $(NEXTDIR) $@
	@echo "Back from $(NEXTDIR)"
	cp $(NEXTDIR)/$(source) ./