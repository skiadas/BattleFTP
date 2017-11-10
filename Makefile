FILES = `find src -type f -name "*.hs"`

doc:
	haddock $(FILES) -h -o docs
