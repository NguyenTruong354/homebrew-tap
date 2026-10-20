class LiveServe < Formula
  desc "Tiny live-reload dev server: one binary, no Node.js"
  homepage "https://github.com/NguyenTruong354/live-serve"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.0/live-serve-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "08692bd88a3a01dd541c043adf29bbec2fdaba0027fda72f72a7e4e38342597a"
    end
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.0/live-serve-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "f0dd6833cc0c358ac783b700d3113d5b05566e7e60db76d468af6019b5475080"
    end
  end

  # Static (musl) binaries: they run on any distribution, old glibc included.
  on_linux do
    on_arm do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.0/live-serve-v0.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f81b0de887171754cbd20bea14056aa8164a47a99ce24b001baf7673678adf56"
    end
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.0/live-serve-v0.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5ff3b2cb084dffa14012016b7678c3ca93b25f23b66eaaebd716c8a1fbf969f7"
    end
  end

  def install
    bin.install "live-serve"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/live-serve --version")
    (testpath/"index.html").write "<h1>hi</h1>"
    port = free_port
    pid = spawn bin/"live-serve", testpath, "--port", port.to_s, "--strict-port", "--no-reload"
    sleep 1
    assert_match "<h1>hi</h1>", shell_output("curl -s http://127.0.0.1:#{port}/")
  ensure
    Process.kill("TERM", pid) if pid
  end
end
