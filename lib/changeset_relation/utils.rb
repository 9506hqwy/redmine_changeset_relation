# frozen_string_literal: true

module RedmineChangesetRelationSetting
  module Utils
    def self.extract_references(message)
      kw =
        Setting.commit_ref_keywords.split(",") |
        Setting.commit_update_keywords_array.map{|r| r['keywords']}.flatten
      kw = kw.map(&:strip).compact.uniq.map(&:downcase)
      wildcard = kw.delete('*')

      kw = kw.map{|kw| Regexp.escape(kw)}.join("|")

      references = []

      message.scan(/((#{kw})[\s:]+)?(#\d+([\s,;&]+#\d+)*)/i) do |match|
        action, refs = match[1].to_s.downcase, match[2]
        next unless action.present? || wildcard

        refs.scan(/#(\d+)/) do |ref|
          references << [action, ref[0].to_i]
        end
      end

      references
    end
  end
end
