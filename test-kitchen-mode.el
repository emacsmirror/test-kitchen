;;; test-kichen-mode.el -- Run test-kitchen inside of emacs

;; Copyright (C) 2015 JJ Asghar <http://jjasghar.github.io>
;; Author: JJ Asghar
;; URL: http://github.com/jjasghar/test-kitchen-mode
;; Created: 2015
;; Version: 0.1.0
;; Keywords: chef ruby test-kitchen
;; Package-Requires:
;;    chefdk [https://downloads.chef.io/chef-dk/]

;; This file is NOT part of GNU Emacs.
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; See <http://www.gnu.org/licenses/> for a copy of the GNU General
;; Public License.

;;; Commentary:

;; inspired from the following sites:
;; http://blog.binchen.org/posts/open-readme-under-git-root-directory-in-emacs.html
;; http://stackoverflow.com/questions/821853/splitting-window-in-emacs-lisp-function
;;
;; I'd like to thank [Cameron Desautels](https://twitter.com/camdez) for the
;; jump start on this project. /me tips my hat to you sir.
;;
;;
;; This minor mode allows you to run test-kitchen in a seporate buffer
;;
;;  * Run test-kitchen destroy in another buffer
;;    (bound to `C-c C-d`)
;;
;;  * Run test-kitchen list in another buffer
;;    (bound to `C-c l`)
;;
;;  * Run test-kitchen test in another buffer
;;    (bound to `C-c C-t`)
;;
;;  * Run test-kitchen verify in another buffer
;;    (bound to `C-c C-v`)
;;

;; TODO:
;;
;; 1) Have a way to select the only one suite to run
;; 2) Have a way to select only one os to run

;;; Code:

(defvar kitchen-destroy-command "chef exec kitchen destroy")
(defvar kitchen-list-command "chef exec kitchen list")
(defvar kitchen-test-command "chef exec kitchen test")
(defvar kitchen-verify-command "chef exec kitchen verify")

(defun locate-root-dir ()
  "Return the full path of the directory where .kitchen.yml file was found, else nil."
  (locate-dominating-file (file-name-as-directory
                           (file-name-directory buffer-file-name))
                          ".kitchen.yml"))

(defun chef-kitchen-destroy ()
  "Run chef exec kitchen destroy in a different buffer."
  (interactive)
  (let ((root-dir (locate-root-dir)))
    (if root-dir
        (let ((default-directory root-dir)
              (out-buffer (get-buffer-create "*chef output*")))
          (async-shell-command kitchen-destroy-command out-buffer)
          (display-buffer out-buffer))
      (error "Couldn't locate .kitchen.yml!"))))

(defun chef-kitchen-list ()
  "Run chef exec kitchen list in a different buffer."
  (interactive)
  (let ((root-dir (locate-root-dir)))
    (if root-dir
        (let ((default-directory root-dir)
              (out-buffer (get-buffer-create "*chef output*")))
          (async-shell-command kitchen-list-command out-buffer)
          (display-buffer out-buffer))
      (error "Couldn't locate .kitchen.yml!"))))

(defun chef-kitchen-test ()
  "Run chef exec kitchen test in a different buffer."
  (interactive)
  (let ((root-dir (locate-root-dir)))
    (if root-dir
        (let ((default-directory root-dir)
              (out-buffer (get-buffer-create "*chef output*")))
          (async-shell-command kitchen-test-command out-buffer)
          (display-buffer out-buffer))
      (error "Couldn't locate .kitchen.yml!"))))

(defun chef-kitchen-verify ()
  "Run chef exec kitchen verify in a different buffer."
  (interactive)
  (let ((root-dir (locate-root-dir)))
    (if root-dir
        (let ((default-directory root-dir)
              (out-buffer (get-buffer-create "*chef output*")))
          (async-shell-command kitchen-verify-command out-buffer)
          (display-buffer out-buffer))
      (error "Couldn't locate .kitchen.yml!"))))


;;; some generic keybindings you'll probably want to change these
(global-set-key (kbd "C-c C-d") 'chef-kitchen-destroy)
(global-set-key (kbd "C-c C-t") 'chef-kitchen-test)
(global-set-key (kbd "C-c l") 'chef-kitchen-list)
(global-set-key (kbd "C-c C-v") 'chef-kitchen-verify)

;;; test-kitchen-mode.el ends here
