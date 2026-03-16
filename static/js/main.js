let pendingDeleteForm = null;

function openDeleteModal({ form, title, message }) {
  const modal = document.getElementById('delete-modal');
  const titleEl = document.getElementById('delete-title');
  const msgEl = document.getElementById('delete-message');
  const confirmBtn = document.getElementById('delete-confirm');
  const cancelBtn = document.getElementById('delete-cancel');

  if (!modal || !titleEl || !msgEl || !confirmBtn || !cancelBtn) return;

  pendingDeleteForm = form || null;
  titleEl.textContent = title || 'Xác nhận xóa';
  msgEl.textContent = message || 'Bạn có chắc muốn xóa mục này?';

  modal.classList.remove('hidden');
  cancelBtn.focus();
}

function closeDeleteModal() {
  const modal = document.getElementById('delete-modal');
  if (!modal) return;
  modal.classList.add('hidden');
  pendingDeleteForm = null;
}

document.addEventListener('click', (e) => {
  const target = e.target.closest('.js-delete');
  if (!target) return;

  const form = target.closest('form');
  if (!form) return;

  e.preventDefault();
  const item = target.getAttribute('data-item') || form.getAttribute('data-item') || 'mục này';
  openDeleteModal({
    form,
    title: 'Xác nhận thao tác',
    message: `Bạn có chắc muốn xóa "${item}"?`,
  });
});

document.getElementById('delete-cancel')?.addEventListener('click', () => closeDeleteModal());
document.getElementById('delete-confirm')?.addEventListener('click', () => {
  if (pendingDeleteForm) pendingDeleteForm.submit();
  closeDeleteModal();
});

document.getElementById('delete-modal')?.addEventListener('click', function (e) {
  if (e.target && e.target.classList.contains('ui-modal-backdrop')) closeDeleteModal();
});

document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') closeDeleteModal();
});

document.querySelectorAll('.ui-toast').forEach((toast) => {
  const timeout = Number(toast.getAttribute('data-timeout') || '0');
  requestAnimationFrame(() => toast.classList.add('ui-toast-show'));
  toast.querySelector('.ui-toast-close')?.addEventListener('click', () => {
    toast.classList.add('ui-toast-hide');
    setTimeout(() => toast.remove(), 180);
  });
  if (timeout > 0) {
    setTimeout(() => {
      toast.classList.add('ui-toast-hide');
      setTimeout(() => toast.remove(), 180);
    }, timeout);
  }
});

document.getElementById('sidebar-toggle')?.addEventListener('click', () => {
  document.getElementById('sidebar')?.classList.toggle('-translate-x-full');
});
