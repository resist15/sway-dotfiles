// Hardware video decode on NVIDIA via nvidia-vaapi-driver (NVDEC)
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.hardware-video-decoding.force-enabled", true);
user_pref("media.rdd-ffmpeg.enabled", true);
user_pref("widget.dmabuf.force-enabled", true);
user_pref("gfx.webrender.all", true);
// GT 1030 has no AV1 decoder -> make sites (YouTube) pick VP9/H.264 instead of CPU-decoded AV1
user_pref("media.av1.enabled", false);
