#!/opt/puppetlabs/puppet/bin/ruby
# frozen_string_literal: true
require 'open3'
require 'puppet'

require_relative "../../ruby_task_helper/files/task_helper.rb"


class MyClass < TaskHelper
  def task(name: nil, **kwargs)
    services, stderr, status = Open3.capture3("puppet resource vsphere_vm")

    raise Puppet::Error, _("Cannot retrieve services.\n#{stderr}") unless status.exitstatus == 0

    {services: services}# apply the patch
  end
end

if __FILE__ == $0
  MyClass.run
end