chang_app_hash() {
  if command -v sha256sum >/dev/null 2>&1; then
    echo "$@" | sha256sum | cut -d' ' -f1 | head -c ${CHANG_APP_HASH_LENGTH}
  elif command -v shasum >/dev/null 2>&1; then
    echo "$@" | shasum -a 256 | cut -d' ' -f1 | head -c ${CHANG_APP_HASH_LENGTH}
  elif command -v openssl >/dev/null 2>&1; then
    echo "$@" | openssl sha256 | cut -d' ' -f2 | head -c ${CHANG_APP_HASH_LENGTH}
  elif command -v md5sum >/dev/null 2>&1; then
    echo "$@" | md5sum | cut -d' ' -f1 | head -c ${CHANG_APP_HASH_LENGTH}
  else
    echo "No supported hash command found" >&2
    exit 1
  fi
}