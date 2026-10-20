class LiveServe < Formula
  desc "Tiny live-reload dev server: one binary, no Node.js"
  homepage "https://github.com/NguyenTruong354/live-serve"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.1/live-serve-v0.4.1-aarch64-apple-darwin.tar.gz"
      sha256 "82fb1652a5a2d5173f25d12e1add8fb51d6bef82e907c29ca6fd48d602f91b89"
    end
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.1/live-serve-v0.4.1-x86_64-apple-darwin.tar.gz"
      sha256 "999c5b5ea44fdc67377677f9d5154b862345a430dd6dcce7c9b7f4ca3369b0ca"
    end
  end

  # Static (musl) binaries: they run on any distribution, old glibc included.
  on_linux do
    on_arm do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.1/live-serve-v0.4.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "579dfcd5c6084c09273519d660fbd0f9d5f2f5e6dc9446b45ffb1f752396b6dd"
    end
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.1/live-serve-v0.4.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e333a7cfe21cf88d3a8f71e9a12d5e78dc81446dbd35888ae30de484f4ffcd48"
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
