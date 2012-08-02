# coding: utf-8
require 'spec_helper'

module AppossFile
  describe "FileEntry" do
    fixtures :apps,:users

    it "创建和删除同步记录" do
      entry = AppossFile::FileEntry.create(
        app_id: App.first.id, 
        refer_type: 'svn', 
        refer_url: 'file:///home/john/svn/ROOT',
        path: '/home/john/temp/svn',
        linkable: true
      )
      entry.should_not be_nil
      OperationTemplate.count.should == 1
      DirectiveTemplate.count.should == 1

      entry.destroy

      OperationTemplate.count.should == 0
      DirectiveTemplate.count.should == 0
    end
  end
end
