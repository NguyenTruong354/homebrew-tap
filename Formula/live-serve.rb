class LiveServe < Formula
  desc "Tiny live-reload dev server: one binary, no Node.js"
  homepage "https://github.com/NguyenTruong354/live-serve"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.3/live-serve-v0.4.3-aarch64-apple-darwin.tar.gz"
      sha256 "cb2af4d036d8bf30eac3e0f9fe6cfedfde398a1339f0c98b2552486fca3556ea"
    end
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.3/live-serve-v0.4.3-x86_64-apple-darwin.tar.gz"
      sha256 "35017d18ab6a65786d244f79cdc8fa92922a1ccad31287ff38cf8b85f03a2dbc"
    end
  end

  # Static (musl) binaries: they run on any distribution, old glibc included.
  on_linux do
    on_arm do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.3/live-serve-v0.4.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5252fb41d33bad4c5d0441ab40dd9b1fd803748cd8ca569170c09953af3b099a"
    end
    on_intel do
      url "https://github.com/NguyenTruong354/live-serve/releases/download/v0.4.3/live-serve-v0.4.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0872effd0f71cf77f6eaf9588a2c053a8000d980985cb2c71697f467ee06fe54"
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
