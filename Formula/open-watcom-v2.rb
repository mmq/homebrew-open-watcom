class OpenWatcomV2 < Formula
  desc "Fork of Open Watcom aimed at 64 bit support"
  homepage "https://github.com/open-watcom/open-watcom-v2/wiki"
  url "https://github.com/open-watcom/open-watcom-v2/archive/refs/tags/2026-06-01-Build.tar.gz"
  version "2.0-2026-06-01"
  sha256 "f876034fae915bcaacce0a4c4d06cd73b4ac91c644127faa416ede9518f56569"
  license "Watcom-1.0"
  head "https://github.com/open-watcom/open-watcom-v2.git", branch: "master"

  bottle do
    root_url "https://github.com/mmq/homebrew-open-watcom/releases/download/open-watcom-v2-2.0-2026-06-01"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "6a6f717c619b815fb6a48331e0696206357c52355d0205aaf1d7e7dbf2944f21"
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
