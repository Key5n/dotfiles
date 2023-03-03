#!/bin/sh

dotfiles_root=$(cd $(dirname $0)/../.. && pwd)

# linklist.txtのコメントを削除
__remove_linklist_comment() {(
    # '#'以降と空行を削除
    sed -e 's/\s*#.*//' \
        -e '/^\s*$/d' \
        $1
)}

# シンボリックリンクを作成
cd ${dotfiles_root}/dotfiles
for linklist in "linklist.Unix.txt" "linklist.$(uname).txt"; do
    [ ! -r "${linklist}" ] && continue

    __remove_linklist_comment "$linklist" | while read target link || [ -n "${target}" -o -n "${list}" ]; do
        # ~ や環境変数を展開
        target=$(eval echo "${PWD}/${target}")
        link=$(eval echo "${link}")
        # シンボリックリンクを作成
        mkdir -p $(dirname ${link})
        ln -fsn ${target} ${link}
    done
done