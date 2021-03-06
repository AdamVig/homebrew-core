class Buildozer < Formula
  desc "Rewrite bazel BUILD files using standard commands"
  homepage "https://github.com/bazelbuild/buildtools"
  url "https://github.com/bazelbuild/buildtools.git",
      tag:      "3.5.0",
      revision: "10384511ce98d864faf064a8ed54cdf31b98ac04"
  license "Apache-2.0"
  head "https://github.com/bazelbuild/buildtools.git"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:     "bec839741e5ae4f36dfb254bc52abc9bc9b89834920755ed2e84cffc078b5cca"
    sha256 cellar: :any_skip_relocation, catalina:    "9fe7f3968698450308a92d4d9518ccc0b67720d730acd2533e752184f8bc1d86"
    sha256 cellar: :any_skip_relocation, mojave:      "8279fdac655641ecc196576b16eeac00727bbeba8d9a811eb20916485c6d6f4a"
    sha256 cellar: :any_skip_relocation, high_sierra: "a257921eb9df552c485cb2656ce7f535a708846308de4aa1ee47942492a61aee"
  end

  disable! date: "2021-02-17", because: :does_not_build

  depends_on "bazelisk" => :build

  def install
    system "bazelisk", "build", "--config=release", "buildozer:buildozer"
    bin.install "bazel-bin/buildozer/darwin_amd64_stripped/buildozer"
  end

  test do
    build_file = testpath/"BUILD"

    touch build_file
    system "#{bin}/buildozer", "new java_library brewed", "//:__pkg__"

    assert_equal "java_library(name = \"brewed\")\n", build_file.read
  end
end
