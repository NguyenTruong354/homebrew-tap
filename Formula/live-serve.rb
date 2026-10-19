class LiveServe < Formula
  desc "Tiny live-reload dev server: one binary, no Node.js"
  homepage "https://github.com/NguyenTruong354/live-serve"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.3.1/live-serve-v0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "e1193e075f2d11d65bbb6b9e92506fbf6001d9f337311a5cca8b573e58ddc4d7"
    end
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.3.1/live-serve-v0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "61ae428819b952545cf82a4a28baa1b0a825ed8bef952438f32de796e5e888b3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.3.1/live-serve-v0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "abd748a87e8fedcdce8cb68a5d5263d5576d14f1291b06c14fc0684e559061a1"
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
