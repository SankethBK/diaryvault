FLUTTER ?= flutter3.32

.PHONY: help pub-get analyze apk-staging apk-prod aab-staging aab-prod run-staging run-prod

help:
	@echo "make apk-staging  Build a staging release APK"
	@echo "make apk-prod     Build a production release APK"
	@echo "make aab-staging  Build a staging Play Store bundle"
	@echo "make aab-prod     Build a production Play Store bundle"
	@echo "make run-staging  Run the staging flavor"
	@echo "make run-prod     Run the production flavor"

pub-get:
	$(FLUTTER) pub get

analyze:
	$(FLUTTER) analyze --no-pub --no-fatal-infos .

apk-staging:
	$(FLUTTER) build apk --flavor staging --split-per-abi --release

apk-prod:
	$(FLUTTER) build apk --flavor prod --split-per-abi --release

aab-staging:
	$(FLUTTER) build appbundle --flavor staging --release

aab-prod:
	$(FLUTTER) build appbundle --flavor prod --release

run-staging:
	$(FLUTTER) run --flavor staging

run-prod:
	$(FLUTTER) run --flavor prod
