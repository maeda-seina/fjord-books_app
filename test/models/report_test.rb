# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable' do
    assert reports(:alice_report).editable?(users(:alice))
    assert_not reports(:alice_report).editable?(users(:bob))
  end

  test '#created_on' do
    alice_report = users(:alice).reports.new(title: 'alice_report', content: 'alice_report_content', created_at: '2020-01-01 11:42:53.052122')
    assert_equal '2020/01/01', I18n.l(alice_report.created_on)
  end
end
