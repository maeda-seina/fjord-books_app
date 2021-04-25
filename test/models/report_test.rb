# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable' do
    alice = users(:alice)
    bob = users(:bob)
    alice_report = reports(:alice_report)

    assert alice_report.editable?(alice)
    assert_not alice_report.editable?(bob)
  end

  test '#created_on' do
    alice = users(:alice)
    alice_report = alice.reports.new(title: 'alice_report', content: 'alice_report_content', created_at: '2020-01-01 11:42:53.052122')

    assert_equal '2020/01/01', I18n.l(alice_report.created_on)
  end
end
