# Redmine Changeset Relation

This plugin provides a relation between changeset and issue using custom field instead of issue's id.

## Installation

1. Download plugin in Redmine plugin directory.
   ```sh
   git clone https://github.com/9506hqwy/redmine_changeset_relation.git
   ```
2. Install plugin in Redmine directory.
   ```sh
   bundle exec rake redmine:plugins:migrate NAME=redmine_changeset_relation RAILS_ENV=production
   ```
3. Start Redmine

## Configuration

1. Create issue's custom field.

2. Set custom field in project repository setting.

3. If re-create relation, Click [OK] on popup after clicking save button.

## Tested Environment

* Redmine (Docker Image)
  * 3.4
  * 4.0
  * 4.1
  * 4.2
  * 5.0
* Database
  * SQLite
  * MySQL 5.7
  * PostgreSQL 12

## Notes

The issue number in commit message is link only if issue exists in redmine.
