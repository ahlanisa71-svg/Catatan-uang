-- CatatUang: aturan keamanan untuk tabel catatan_uang
-- Jalankan di Supabase > SQL Editor SETELAH semua pengguna membuka versi 2.4.9 dan masuk sekali
-- (supaya data lama sudah dienkripsi). Data baru berisi teks acak terenkripsi, bukan teks terbuka.

alter table public.catatan_uang enable row level security;

-- Hapus aturan lama bila ada
drop policy if exists "catatuang_select" on public.catatan_uang;
drop policy if exists "catatuang_insert" on public.catatan_uang;
drop policy if exists "catatuang_update" on public.catatan_uang;

-- Baca: diperlukan aplikasi untuk sinkron (isi sudah terenkripsi)
create policy "catatuang_select" on public.catatan_uang
  for select to anon using (true);

-- Tambah: hanya baris terenkripsi, ukuran dibatasi
create policy "catatuang_insert" on public.catatan_uang
  for insert to anon
  with check (tipe = 'enc' and jumlah = 0 and length(keterangan) < 2000000);

-- Ubah: hasilnya harus tetap baris terenkripsi
create policy "catatuang_update" on public.catatan_uang
  for update to anon
  using (true)
  with check (tipe = 'enc' and jumlah = 0 and length(keterangan) < 2000000);

-- Tidak ada aturan DELETE: kunci publik tidak bisa menghapus data siapa pun.
