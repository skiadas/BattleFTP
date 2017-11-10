FILES = Game.hs

doc:
	haddock $(FILES) -h -o docs
