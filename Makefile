.PHONY: install run run_production console test

ifeq (test,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "test"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

install:
	bundle config path .bundle
	bundle
	touch .env.test
	touch .env.development

run:
	bundle exec rerun -b --pattern '{Gemfile,Gemfile.lock,.gems,.bundle,.env*,config.ru,**/*.{rb,ru,yml}}' -- thin start --port=3000 --threaded

console:
	bundle exec pry -r ./application/api

test:
ifeq ($(RUN_ARGS),)
		bundle exec rake spec
else
		bundle exec rake spec SPEC=$(RUN_ARGS)
endif
