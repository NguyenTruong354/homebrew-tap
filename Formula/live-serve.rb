class LiveServe < Formula
  desc "Tiny live-reload dev server: one binary, no Node.js"
  homepage "https://github.com/NguyenTruong354/live-serve"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.2/live-serve-v0.4.2-aarch64-apple-darwin.tar.gz"
      sha256 "a812c356c6e36262f900adfdea96cf6b46792b17e42cd6127f86bb0ae7796748"
    end
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.2/live-serve-v0.4.2-x86_64-apple-darwin.tar.gz"
      sha256 "81c1ecf10182a109e1af6be717240f3c5e24c2778b64c926d4e6e6d6042d13df"
    end
  end

  # Static (musl) binaries: they run on any distribution, old glibc included.
  on_linux do
    on_arm do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.2/live-serve-v0.4.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "186ea17c0cbe976c3bbfb294d0afa2fb1b6ee20066b1346ddf387ac9fa282d45"
    end
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.2/live-serve-v0.4.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ba4daa459ca84e3e4e6b57072da88f35bae388aeff1be3473fd18242d9872e38"
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
