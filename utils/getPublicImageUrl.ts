// utils/getPublicImageUrl.ts

const CLOUDFLARE_R2_BASE_URL = "https://assets.transformik.com";

function isFullUrl(value: string) {
  return value.startsWith("http://") || value.startsWith("https://");
}

export function getPublicImageUrl(bucket: string, path?: string) {
  if (!path) return undefined;

  // Caller may already have a bare full URL (no prefix at all).
  if (isFullUrl(path)) return path;

  // toolgen now writes the full R2 URL directly into tools_summary.logo /
  // tools_details.screenshots for newly-pushed tools, instead of a bare
  // filename. Call sites still do `ToolLogos/${tool.logo}` /
  // `ToolScreenshot/${fileName}` before calling this, so strip that known
  // prefix first and pass the real URL through untouched. Legacy rows
  // (pre-toolgen-push, still a bare filename after stripping) fall through
  // to the rewrite below unchanged.
  const withoutLogoPrefix = path.startsWith("ToolLogos/") ? path.slice("ToolLogos/".length) : null;
  const withoutScreenshotPrefix = path.startsWith("ToolScreenshot/") ? path.slice("ToolScreenshot/".length) : null;
  const stripped = withoutLogoPrefix ?? withoutScreenshotPrefix;
  if (stripped && isFullUrl(stripped)) return stripped;

  // Extract filename from path (e.g., "ToolLogos/10web.png" -> "10web.png")
  const filename = path.split("/").pop();
  if (!filename) return undefined;

  // Map bucket and path to Cloudflare R2 structure
  if (bucket === "Images" && path.startsWith("ToolLogos/")) {
    return `${CLOUDFLARE_R2_BASE_URL}/tool-logos/${filename}`;
  }

  if (bucket === "Images" && path.startsWith("ToolScreenshot/")) {
    return `${CLOUDFLARE_R2_BASE_URL}/tool-screenshots/${filename}`;
  }

  // Default fallback for other paths
  return `${CLOUDFLARE_R2_BASE_URL}/${path}`;
}
