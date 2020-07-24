# frozen_string_literal: true

module Homebrew
  module Tests
    class TapSyntax < Test
      def run!
        test_header(:TapSyntax)

        test "brew", "readall", "--aliases", tap.name
        broken_xcode_rubygems = MacOS.version == :mojave &&
                                MacOS.active_developer_dir == "/Applications/Xcode.app/Contents/Developer"
        return if broken_xcode_rubygems

        if ENV["HOMEBREW_GITHUB_ACTIONS"].present?
          problem_matcher { test "brew", "style", tap.name }
        else
          test "brew", "style", tap.name
        end
      end
    end
  end
end
