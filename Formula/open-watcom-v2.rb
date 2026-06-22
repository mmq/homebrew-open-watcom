class OpenWatcomV2 < Formula
  desc "Fork of Open Watcom aimed at 64 bit support"
  homepage "https://github.com/open-watcom/open-watcom-v2/wiki"
  url "https://github.com/open-watcom/open-watcom-v2/archive/refs/tags/2026-06-01-Build.tar.gz"
  version "2.0-2026-06-01"
  sha256 "f876034fae915bcaacce0a4c4d06cd73b4ac91c644127faa416ede9518f56569"
  license "Watcom-1.0"
  head "https://github.com/open-watcom/open-watcom-v2.git", branch: "master"

  bottle do
    root_url "https://github.com/btb/homebrew-open-watcom/releases/download/open-watcom-v2-2.0-2021-08-01"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:     "0a100d7bcd7cb1c8f8c55bf346abbb00f21e3ee192ffaf0cc906001b61cc627b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "56f7d87d889f80d7c26f94f4dbf47393bdafd1fa67729c38abcbf0289a13582e"
  end

  env :std

  keg_only "you should use a script to set up your dev environment"

  depends_on "dosbox-x" => :build
  depends_on :macos

  def install
    ENV.deparallelize do # race conditions in bld/wmake/posmake
      inreplace "setvars.sh", 'export OWROOT=$(realpath "`pwd`")', "export OWROOT=#{buildpath}"
      inreplace "setvars.sh", "export OWTOOLS=GCC", "export OWTOOLS=CLANG"
      ENV["OWDOSBOX"] = "dosbox-x"
      ENV["OWRELROOT"] = prefix
      system("./build.sh", "rel")
    end
  end

  test do
    system "true"
  end
end
