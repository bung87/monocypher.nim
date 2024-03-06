import os
# Generated @ 2024-03-06T10:17:32+08:00
# Command line:
#   /Users/bung/.nimble/pkgs2/nimterop-0.6.13-a93246b2ad5531db11e51de7b2d188c42d95576a/nimterop/toast --preprocess -m:c --compile+=/Users/bung/nim-works/monocypher.nim/monocypher/build/src/monocypher.c --pnim --nim:/Users/bung/.choosenim/toolchains/nim-#devel/bin/nim /Users/bung/nim-works/monocypher.nim/monocypher/build/src/monocypher.h -o /Users/bung/.cache/nim/nimterop/toastCache/nimterop_2603924568.nim

# const 'crypto_key_exchange_public_key' has unsupported value 'crypto_x25519_public_key'
{.push hint[ConvFromXtoItselfNotNeeded]: off.}


{.pragma: impmonocypherHdr, header: currentSourcePath.parentDir / "monocypher.h".}
{.experimental: "codeReordering".}
{.compile:  currentSourcePath.parentDir / "monocypher.c".}
type
  crypto_sign_vtable* {.bycopy, importc, impmonocypherHdr.} = object ## ```
                                                                      ##   / Type definitions /
                                                                      ##     
                                                                      ##      Vtable for EdDSA with a custom hash.
                                                                      ##      Instantiate it to define a custom hash.
                                                                      ##      Its size, contents, and layout, are part of the public API.
                                                                      ## ```
    hash*: proc (hash: array[64, uint8]; message: ptr uint8; message_size: uint) {.
        cdecl.}
    init*: proc (ctx: pointer) {.cdecl.}
    update*: proc (ctx: pointer; message: ptr uint8; message_size: uint) {.cdecl.}
    final*: proc (ctx: pointer; hash: array[64, uint8]) {.cdecl.}
    ctx_size*: uint
  crypto_poly1305_ctx* {.bycopy, importc, impmonocypherHdr.} = object ## ```
                                                                       ##   Do not rely on the size or contents of any of the types below,
                                                                       ##      they may change without notice.
                                                                       ##      Poly1305
                                                                       ## ```
    r*: array[4, uint32]     ## ```
                             ##   constant multiplier (from the secret key)
                             ## ```
    h*: array[5, uint32]     ## ```
                             ##   accumulated hash
                             ## ```
    c*: array[5, uint32]     ## ```
                             ##   chunk of the message
                             ## ```
    pad*: array[4, uint32] ## ```
                           ##   random number added at the end (from the secret key)
                           ## ```
    c_idx*: uint             ## ```
                             ##   How many bytes are there in the chunk.
                             ## ```
  crypto_blake2b_ctx* {.bycopy, importc, impmonocypherHdr.} = object ## ```
                                                                      ##   Hash (Blake2b)
                                                                      ## ```
    hash*: array[8, uint64]
    input_offset*: array[2, uint64]
    input*: array[16, uint64]
    input_idx*: uint
    hash_size*: uint
  crypto_sign_ctx_abstract* {.bycopy, importc, impmonocypherHdr.} = object ## ```
                                                                            ##   Signatures (EdDSA)
                                                                            ## ```
    hash*: ptr crypto_sign_vtable
    buf*: array[96, uint8]
    pk*: array[32, uint8]
  crypto_check_ctx_abstract* {.importc, impmonocypherHdr.} = crypto_sign_ctx_abstract
  crypto_sign_ctx* {.bycopy, importc, impmonocypherHdr.} = object
    ctx*: crypto_sign_ctx_abstract
    hash*: crypto_blake2b_ctx
  crypto_check_ctx* {.importc, impmonocypherHdr.} = crypto_sign_ctx
var crypto_blake2b_vtable* {.importc, impmonocypherHdr.}: crypto_sign_vtable ## ```
                                                                             ##   vtable for signatures
                                                                             ## ```
proc crypto_verify16*(a: array[16, uint8]; b: array[16, uint8]): cint {.importc,
    cdecl, impmonocypherHdr.}
  ## ```
                             ##   / High level interface /
                             ##     
                             ##      Constant time comparisons
                             ##      -------------------------
                             ##      Return 0 if a and b are equal, -1 otherwise
                             ## ```
proc crypto_verify32*(a: array[32, uint8]; b: array[32, uint8]): cint {.importc,
    cdecl, impmonocypherHdr.}
proc crypto_verify64*(a: array[64, uint8]; b: array[64, uint8]): cint {.importc,
    cdecl, impmonocypherHdr.}
proc crypto_wipe*(secret: pointer; size: uint) {.importc, cdecl,
    impmonocypherHdr.}
  ## ```
                      ##   Erase sensitive data
                      ##      --------------------
                      ##      Please erase all copies
                      ## ```
proc crypto_lock*(mac: array[16, uint8]; cipher_text: ptr uint8;
                  key: array[32, uint8]; nonce: array[24, uint8];
                  plain_text: ptr uint8; text_size: uint) {.importc, cdecl,
    impmonocypherHdr.}
  ## ```
                      ##   Authenticated encryption
                      ##      ------------------------
                      ## ```
proc crypto_unlock*(plain_text: ptr uint8; key: array[32, uint8];
                    nonce: array[24, uint8]; mac: array[16, uint8];
                    cipher_text: ptr uint8; text_size: uint): cint {.importc,
    cdecl, impmonocypherHdr.}
proc crypto_lock_aead*(mac: array[16, uint8]; cipher_text: ptr uint8;
                       key: array[32, uint8]; nonce: array[24, uint8];
                       ad: ptr uint8; ad_size: uint; plain_text: ptr uint8;
                       text_size: uint) {.importc, cdecl, impmonocypherHdr.}
  ## ```
                                                                            ##   With additional data
                                                                            ## ```
proc crypto_unlock_aead*(plain_text: ptr uint8; key: array[32, uint8];
                         nonce: array[24, uint8]; mac: array[16, uint8];
                         ad: ptr uint8; ad_size: uint; cipher_text: ptr uint8;
                         text_size: uint): cint {.importc, cdecl,
    impmonocypherHdr.}
proc crypto_blake2b*(hash: array[64, uint8]; message: ptr uint8;
                     message_size: uint) {.importc, cdecl, impmonocypherHdr.}
  ## ```
                                                                             ##   General purpose hash (Blake2b)
                                                                             ##      ------------------------------
                                                                             ##      Direct interface
                                                                             ## ```
proc crypto_blake2b_general*(hash: ptr uint8; hash_size: uint; key: ptr uint8;
                             key_size: uint; message: ptr uint8;
                             message_size: uint) {.importc, cdecl,
    impmonocypherHdr.}
proc crypto_blake2b_init*(ctx: ptr crypto_blake2b_ctx) {.importc, cdecl,
    impmonocypherHdr.}
  ## ```
                      ##   Incremental interface
                      ## ```
proc crypto_blake2b_update*(ctx: ptr crypto_blake2b_ctx; message: ptr uint8;
                            message_size: uint) {.importc, cdecl,
    impmonocypherHdr.}
proc crypto_blake2b_final*(ctx: ptr crypto_blake2b_ctx; hash: ptr uint8) {.
    importc, cdecl, impmonocypherHdr.}
proc crypto_blake2b_general_init*(ctx: ptr crypto_blake2b_ctx; hash_size: uint;
                                  key: ptr uint8; key_size: uint) {.importc,
    cdecl, impmonocypherHdr.}
proc crypto_argon2i*(hash: ptr uint8; hash_size: uint32; work_area: pointer;
                     nb_blocks: uint32; nb_iterations: uint32;
                     password: ptr uint8; password_size: uint32;
                     salt: ptr uint8; salt_size: uint32) {.importc, cdecl,
    impmonocypherHdr.}
  ## ```
                      ##   Password key derivation (Argon2 i)
                      ##      ----------------------------------
                      ## ```
proc crypto_argon2i_general*(hash: ptr uint8; hash_size: uint32;
                             work_area: pointer; nb_blocks: uint32;
                             nb_iterations: uint32; password: ptr uint8;
                             password_size: uint32; salt: ptr uint8;
                             salt_size: uint32; key: ptr uint8;
                             key_size: uint32; ad: ptr uint8; ad_size: uint32) {.
    importc, cdecl, impmonocypherHdr.}
proc crypto_key_exchange*(shared_key: array[32, uint8];
                          your_secret_key: array[32, uint8];
                          their_public_key: array[32, uint8]) {.importc, cdecl,
    impmonocypherHdr.}
proc crypto_sign_public_key*(public_key: array[32, uint8];
                             secret_key: array[32, uint8]) {.importc, cdecl,
    impmonocypherHdr.}
  ## ```
                      ##   Signatures (EdDSA with curve25519 + Blake2b)
                      ##      --------------------------------------------
                      ##      Generate public key
                      ## ```
proc crypto_sign*(signature: array[64, uint8]; secret_key: array[32, uint8];
                  public_key: array[32, uint8]; message: ptr uint8;
                  message_size: uint) {.importc, cdecl, impmonocypherHdr.}
  ## ```
                                                                          ##   Direct interface
                                                                          ## ```
proc crypto_check*(signature: array[64, uint8]; public_key: array[32, uint8];
                   message: ptr uint8; message_size: uint): cint {.importc,
    cdecl, impmonocypherHdr.}
proc crypto_hchacha20*(`out`: array[32, uint8]; key: array[32, uint8];
                       `in`: array[16, uint8]) {.importc, cdecl,
    impmonocypherHdr.}
  ## ```
                      ##   / Low level primitives /
                      ##     
                      ##      For experts only.  You have been warned.
                      ##      Chacha20
                      ##      --------
                      ##      Specialised hash.
                      ##      Used to hash X25519 shared secrets.
                      ## ```
proc crypto_chacha20*(cipher_text: ptr uint8; plain_text: ptr uint8;
                      text_size: uint; key: array[32, uint8];
                      nonce: array[8, uint8]) {.importc, cdecl, impmonocypherHdr.}
  ## ```
                                                                                  ##   Unauthenticated stream cipher.
                                                                                  ##      Don't forget to add authentication.
                                                                                  ## ```
proc crypto_xchacha20*(cipher_text: ptr uint8; plain_text: ptr uint8;
                       text_size: uint; key: array[32, uint8];
                       nonce: array[24, uint8]) {.importc, cdecl,
    impmonocypherHdr.}
proc crypto_ietf_chacha20*(cipher_text: ptr uint8; plain_text: ptr uint8;
                           text_size: uint; key: array[32, uint8];
                           nonce: array[12, uint8]) {.importc, cdecl,
    impmonocypherHdr.}
proc crypto_chacha20_ctr*(cipher_text: ptr uint8; plain_text: ptr uint8;
                          text_size: uint; key: array[32, uint8];
                          nonce: array[8, uint8]; ctr: uint64): uint64 {.
    importc, cdecl, impmonocypherHdr.}
proc crypto_xchacha20_ctr*(cipher_text: ptr uint8; plain_text: ptr uint8;
                           text_size: uint; key: array[32, uint8];
                           nonce: array[24, uint8]; ctr: uint64): uint64 {.
    importc, cdecl, impmonocypherHdr.}
proc crypto_ietf_chacha20_ctr*(cipher_text: ptr uint8; plain_text: ptr uint8;
                               text_size: uint; key: array[32, uint8];
                               nonce: array[12, uint8]; ctr: uint32): uint32 {.
    importc, cdecl, impmonocypherHdr.}
proc crypto_poly1305*(mac: array[16, uint8]; message: ptr uint8;
                      message_size: uint; key: array[32, uint8]) {.importc,
    cdecl, impmonocypherHdr.}
  ## ```
                             ##   Poly 1305
                             ##      ---------
                             ##      This is aone time* authenticator.
                             ##      Disclosing the mac reveals the key.
                             ##      See crypto_lock() on how to use it properly.
                             ##      Direct interface
                             ## ```
proc crypto_poly1305_init*(ctx: ptr crypto_poly1305_ctx; key: array[32, uint8]) {.
    importc, cdecl, impmonocypherHdr.}
  ## ```
                                      ##   Incremental interface
                                      ## ```
proc crypto_poly1305_update*(ctx: ptr crypto_poly1305_ctx; message: ptr uint8;
                             message_size: uint) {.importc, cdecl,
    impmonocypherHdr.}
proc crypto_poly1305_final*(ctx: ptr crypto_poly1305_ctx; mac: array[16, uint8]) {.
    importc, cdecl, impmonocypherHdr.}
proc crypto_x25519_public_key*(public_key: array[32, uint8];
                               secret_key: array[32, uint8]) {.importc, cdecl,
    impmonocypherHdr.}
  ## ```
                      ##   X-25519
                      ##      -------
                      ##      Shared secrets are not quite random.
                      ##      Hash them to derive an actual shared key.
                      ## ```
proc crypto_x25519*(raw_shared_secret: array[32, uint8];
                    your_secret_key: array[32, uint8];
                    their_public_key: array[32, uint8]) {.importc, cdecl,
    impmonocypherHdr.}
proc crypto_x25519_dirty_small*(pk: array[32, uint8]; sk: array[32, uint8]) {.
    importc, cdecl, impmonocypherHdr.}
  ## ```
                                      ##   "Dirty" versions of x25519_public_key()
                                      ##      Only use to generate ephemeral keys you want to hide.
                                      ##      Note that those functions leaks 3 bits of the private key.
                                      ## ```
proc crypto_x25519_dirty_fast*(pk: array[32, uint8]; sk: array[32, uint8]) {.
    importc, cdecl, impmonocypherHdr.}
proc crypto_x25519_inverse*(blind_salt: array[32, uint8];
                            private_key: array[32, uint8];
                            curve_point: array[32, uint8]) {.importc, cdecl,
    impmonocypherHdr.}
  ## ```
                      ##   scalar "division"
                      ##      Used for OPRF.  Be aware that exponential blinding is less secure
                      ##      than Diffie-Hellman key exchange.
                      ## ```
proc crypto_from_eddsa_private*(x25519: array[32, uint8];
                                eddsa: array[32, uint8]) {.importc, cdecl,
    impmonocypherHdr.}
  ## ```
                      ##   EdDSA to X25519
                      ##      ---------------
                      ## ```
proc crypto_from_eddsa_public*(x25519: array[32, uint8]; eddsa: array[32, uint8]) {.
    importc, cdecl, impmonocypherHdr.}
proc crypto_sign_init_first_pass*(ctx: ptr crypto_sign_ctx_abstract;
                                  secret_key: array[32, uint8];
                                  public_key: array[32, uint8]) {.importc,
    cdecl, impmonocypherHdr.}
  ## ```
                             ##   EdDSA -- Incremental interface
                             ##      ------------------------------
                             ##      Signing (2 passes)
                             ##      Make sure the two passes hash the same message,
                             ##      else you might reveal the private key.
                             ## ```
proc crypto_sign_update*(ctx: ptr crypto_sign_ctx_abstract; message: ptr uint8;
                         message_size: uint) {.importc, cdecl, impmonocypherHdr.}
proc crypto_sign_init_second_pass*(ctx: ptr crypto_sign_ctx_abstract) {.importc,
    cdecl, impmonocypherHdr.}
  ## ```
                             ##   use crypto_sign_update() again.
                             ## ```
proc crypto_sign_final*(ctx: ptr crypto_sign_ctx_abstract;
                        signature: array[64, uint8]) {.importc, cdecl,
    impmonocypherHdr.}
  ## ```
                      ##   use crypto_sign_update() again.
                      ## ```
proc crypto_check_init*(ctx: ptr crypto_check_ctx_abstract;
                        signature: array[64, uint8];
                        public_key: array[32, uint8]) {.importc, cdecl,
    impmonocypherHdr.}
  ## ```
                      ##   Verification (1 pass)
                      ##      Make sure you don't use (parts of) the message
                      ##      before you're done checking it.
                      ## ```
proc crypto_check_update*(ctx: ptr crypto_check_ctx_abstract;
                          message: ptr uint8; message_size: uint) {.importc,
    cdecl, impmonocypherHdr.}
proc crypto_check_final*(ctx: ptr crypto_check_ctx_abstract): cint {.importc,
    cdecl, impmonocypherHdr.}
proc crypto_sign_public_key_custom_hash*(public_key: array[32, uint8];
    secret_key: array[32, uint8]; hash: ptr crypto_sign_vtable) {.importc,
    cdecl, impmonocypherHdr.}
  ## ```
                             ##   Custom hash interface
                             ## ```
proc crypto_sign_init_first_pass_custom_hash*(ctx: ptr crypto_sign_ctx_abstract;
    secret_key: array[32, uint8]; public_key: array[32, uint8];
    hash: ptr crypto_sign_vtable) {.importc, cdecl, impmonocypherHdr.}
proc crypto_check_init_custom_hash*(ctx: ptr crypto_check_ctx_abstract;
                                    signature: array[64, uint8];
                                    public_key: array[32, uint8];
                                    hash: ptr crypto_sign_vtable) {.importc,
    cdecl, impmonocypherHdr.}
proc crypto_hidden_to_curve*(curve: array[32, uint8]; hidden: array[32, uint8]) {.
    importc, cdecl, impmonocypherHdr.}
  ## ```
                                      ##   Elligator 2
                                      ##      -----------
                                      ##      Elligator mappings proper
                                      ## ```
proc crypto_curve_to_hidden*(hidden: array[32, uint8]; curve: array[32, uint8];
                             tweak: uint8): cint {.importc, cdecl,
    impmonocypherHdr.}
proc crypto_hidden_key_pair*(hidden: array[32, uint8];
                             secret_key: array[32, uint8];
                             seed: array[32, uint8]) {.importc, cdecl,
    impmonocypherHdr.}
  ## ```
                      ##   Easy to use key pair generation
                      ## ```
{.pop.}
