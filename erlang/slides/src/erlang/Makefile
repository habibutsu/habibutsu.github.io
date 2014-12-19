EBIN_DIR := ebin
ERLC := erlc
LIB_DIR := "../erlmonads/ebin"
ERLC_FLAGS := +debug_info -W -o $(EBIN_DIR) -pa $(LIB_DIR)

all:
	@mkdir -p $(EBIN_DIR)
	$(ERLC) $(ERLC_FLAGS) *.erl

clean:
	@rm -rf $(EBIN_DIR)/*
	@rm -f erl_crash.dump