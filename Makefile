.PHONY: reset-db
reset-db:
	docker-compose exec app sh -c "rake db:migrate:reset && rake ridgepole:apply && rake db:seed"
