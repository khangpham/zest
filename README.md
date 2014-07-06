Setup
=====

Populate the database with the provided seed database in **water_sample_schema.sql**

```bash
> mysql -h localhost -u <username> -p -D factor_hw < water_sample_schema.sql 
```

Create your database connection configuration in database.yml.

```bash
> cp database.yml.example database.yml
```

Install dependency gems

```bash
> bundle
```

Define your database connection info
```yaml
host: localhost
database: factor_hw
port: 3306
username: 
password: 
```

Run Tests
=========

To run all tests, issue this command:

```bash
> rspec
```
