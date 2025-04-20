" ===================== VIMRC Configuration =====================
source $VIMRUNTIME/defaults.vim     " Load default Vim settings from runtime directory

" ===================== Auto-install VimPlug =====================
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===================== Plugins =====================
call plug#begin()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
call plug#end()

" ===================== Basic Vim Settings =====================
set number
set relativenumber
set scrolloff=8
set clipboard=unnamed
set noswapfile
colorscheme desert

" ===================== Key Mappings =====================
let mapleader = " "
nnoremap <leader>sf :Files ./<CR>
nnoremap <leader>e  :Ex<CR>
nnoremap <leader>sg :Rg<Space>

