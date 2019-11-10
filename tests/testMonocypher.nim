import unittest
import knownhashes
import sysrandom
import monocypher

test "hashing byte arrays":
  check crypto_blake2b(empty.toBytes()) == knownHashes[empty].toBytes()
  check crypto_blake2b(quick.toBytes()) == knownHashes[quick].toBytes()
test "key exchange":
  let secret1, secret2: Key = getRandomBytes(sizeof(Key))
  let public1 = crypto_key_exchange_public_key(secret1)
  let public2 = crypto_key_exchange_public_key(secret2)
  let shared1 = crypto_key_exchange(secret1, public2)
  let shared2 = crypto_key_exchange(secret2, public1)
  check shared1 == shared2

test "signing":
  let secretKey: Key = getRandomBytes(sizeof(Key))
  let publicKey: Key = crypto_sign_public_key(secretKey)
  let message = cast[seq[byte]]("hello")

  let signature = crypto_sign(secretKey, publicKey, message)

  check crypto_check(signature, publicKey, message)
  check not crypto_check(signature, publicKey, message & 42u8)

test "encrypt and decrypt":
  let key: Key = getRandomBytes(sizeof(Key))
  let nonce: Nonce = getRandomBytes(sizeof(Nonce))
  let plaintext = cast[seq[byte]]("hello")
  let (mac, ciphertext) = crypto_lock(key, nonce, plaintext)
  let decrypted = crypto_unlock(key, nonce, mac, ciphertext)

  check decrypted == plaintext

test "decryption failure":
  let key: Key = getRandomBytes(sizeof(Key))
  let nonce: Nonce = getRandomBytes(sizeof(Nonce))
  let mac = getRandomBytes(sizeof(Mac))
  let cipherText = getRandomBytes(42)
  expect IOError:
    discard crypto_unlock(key, nonce, mac, ciphertext)

test "wipe":
  let secretKey: Key = getRandomBytes(sizeof(Key))
  crypto_wipe(secretKey)
  var empty: Key
  check secretKey == empty
