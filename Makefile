FILES = `find src -type f -name "*.hs"`

doc:
	haddock $(FILES) -h -o docs

exec:
	ghc -isrc --make src/BattleFTP.hs -o battleftp
