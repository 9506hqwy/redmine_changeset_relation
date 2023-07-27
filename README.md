# Redmine Changeset Relation

This plugin provides a relation between changeset and issue using custom field instead of issue's id.

This plugin is based on `Referencing and fixing issues in commit messages` function.
So need to contains reference value in commit message.
If custom field in the issue has same reference value, the changeset is related to the issue.

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
   Issue's custom field visibility is `to any users`.

2. Set custom field at repository tab on project settings.

3. If re-create relation, Click [OK] on popup after clicking save button.

4. Input reference value into custom field on issue editing.
   Changeset that commit message has same reference value is related to the issue.

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
