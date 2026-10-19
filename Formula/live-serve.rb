class LiveServe < Formula
  desc "Tiny live-reload dev server: one binary, no Node.js"
  homepage "https://github.com/NguyenTruong354/live-serve"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.3.2/live-serve-v0.3.2-aarch64-apple-darwin.tar.gz"
      sha256 "1a294f8a162644b94c2ae5d767c62e123d6fc63a23d2c21349701b14c5e0cf08"
    end
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.3.2/live-serve-v0.3.2-x86_64-apple-darwin.tar.gz"
      sha256 "4797aac6c5a8016dce23a776f9434b424ee9c9a884b653d0e4f062fa91dd6e3c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.3.2/live-serve-v0.3.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d8804fb121e66633277aa63b14aa320344dfbf800da72398db6b4b425a8c3c96"
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
