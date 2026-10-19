class LiveServe < Formula
  desc "Tiny live-reload dev server: one binary, no Node.js"
  homepage "https://github.com/NguyenTruong354/live-serve"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.3.3/live-serve-v0.3.3-aarch64-apple-darwin.tar.gz"
      sha256 "defa951f39e5feddfe7182b064dc4fbbe3b9954b3551accd20e284e6163cad87"
    end
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.3.3/live-serve-v0.3.3-x86_64-apple-darwin.tar.gz"
      sha256 "d07c2c1e9dc0023f1617fe0846ab88c8e563b10943610b49aea7a80d378975c2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.3.3/live-serve-v0.3.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2bddc6f8cc6a41d881abb975f1dcefebfcd52bd2c3b99c5394186860256c9fc7"
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
