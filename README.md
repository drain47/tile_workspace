Инструкция по установке Arch Linux

	Скачать последнюю версию образа: https://www.archlinux.org/download/


Подключение к Интернет

	Провод:
		systemctl enable dhcpcd
		systemctl start dhcpcd
	
	Wi-Fi:
		Просмотр интерфейсов:
			iw dev
		Активация интерфейса:
			ip link set ИМЯ_ИНТЕРФЕЙСА up
		Сканируем сети:
			iw dev ИМЯ_ИНТЕРФЕЙСА scan | grep SSID
		Создание конфига:
			wpa_passphrase BSSID_СЕТИ ПАРОЛЬ_СЕТИ > ИМЯ_НОВОГО_КОНФИГА.conf
		Подключение:
			wpa_supplicant -B -i ИМЯ_ИНТЕРФЕЙСА -c ИМЯ_ЗОЗДАННОГО_КОНФИГА.conf
		Получение настроек:
			dhclient ИМЯ_ИНТЕРФЕЙСА
	
	Проверка подключения:
		ping google.com


Разметка диска

	Просмотр дисков:
		fdisk -l
	Разметка диска (пример - /dev/sda):
		cfdisk /dev/sda
		создаем ext4 от 20gb (пример - /dev/sda2)
	Форматирование разделов:
		mkfs.ext4 /dev/sda2 -L root
	Монтирование разделов:
		mount /dev/sda2 /mnt


Установка системы

	Исправление ключей:
		pacman -Sy archlinux-keyring && pacman -Sy
	Установка базовых пакетов:
		pacstrap -i /mnt base base-devel linux linux-firmware linux-headers archlinux-keyring sudo grub os-prober hwinfo dialog rp-pppoe dhcpcd wpa_supplicant dhclient iw git bash-completion unzip python python-gobject unrar ntfs-3g nano mc p7zip networkmanager
	Создаём файл fstab:
		genfstab -p /mnt >> /mnt/etc/fstab


Настройка системы

	Переходим в систему:
		arch-chroot /mnt
	Открываем locale.gen и раскомментируем строки en_US.UTF-8 UTF-8 и ru_RU.UTF-8 UTF-8:
		nano /etc/locale.gen
	Выполняем:
		locale-gen
	Создадим locale.conf и экспортируем английскую локаль на время установки:
		echo LANG=en_US.UTF-8 > /etc/locale.conf
		export LANG=en_US.UTF-8
	Устонавливаем имя хоста:
		echo ЛЮБОЕ_ИМЯ > /etc/hostname
	Установим временную зону:
		timedatectl set-timezone Europe/Moscow
	Устанавливаем пароль root:
		passwd
	Откроем файл /etc/mkinitcpio.conf:
		nano /etc/mkinitcpio.conf
			В разделе HOOKS, должен быть прописан хук keymap.
			В разделе MODULES нужно прописать свой драйвер видеокарты: i915 для Intel, radeon для AMD, nouveau для Nvidia
	Создаем нового пользователя:
		useradd -m -g users -G audio,games,lp,optical,power,scanner,storage,video,wheel -s /bin/bash ИМЯ_НОВОГО_ПОЛЬЗОВАТЕЛЯ
	Устанавливаем для него пароль:
		passwd ИМЯ_СОЗДАННОГО_ПОЛЬЗОВАТЕЛЯ
	Открываем /etc/sudoers и раскомментируем "%wheel ALL=(ALL:ALL) ALL":
		nano /etc/sudoers
	Открываем pacman.conf:
		nano /etc/pacman.conf
			Раскомментируем все репозитории пример:
			#[multilib]
			#Include = /etc/pacman.d/mirrorlist
	Поставим российское зеркало выше всех остальных:
		nano /etc/pacman.d/mirrorlist
		добавляем вверх списка:
			Server = http://mirror.yandex.ru/archlinux/$repo/os/$arch
			

Установка загрузчика

	Создадим загрузочный RAM диск:
		mkinitcpio -p linux
	Установим Grub (для BIOS):
		grub-install /dev/sda
	Добавление Windows в загрузчик (если нужно):
		Определяем UUID раздела с Windows (пример - Windows на /dev/sda1):
			blkid /dev/sda1
		Открываем /etc/grub.d/40_custom:
			nano /etc/grub.d/40_custom
			Добавляем в конец код:
				menuentry "Windows 10" {
					insmod ntfs
					set root='(hd0,1)'
					search --no-floppy --fs-uuid --set НАЙДЕННЫЙ_UUID
					chainloader +1
				}
	Обновляем конфиг Grub:
		grub-mkconfig -o /boot/grub/grub.cfg
		

Установка Xorg

	Основные пакеты:
		sudo pacman -S xorg mesa xorg-xinit xorg-apps xorg-server xf86-input-synaptics xterm
	Драйвер видеокарты:
		Intel:
			sudo pacman -S xf86-video-intel
		Nvidia:
			sudo pacman -S xf86-video-nouveau
		AMD:
			sudo pacman -S xf86-video-ati
		Виртуальная машина:
			sudo pacman -S xf86-video-vesa


Установка подобранного графического окружения

	Установка пакетов:
		sudo pacman -S sxhkd bspwm polybar picom feh kitty chromium telegram-desktop pcmanfm code xarchiver rofi alsa-utils alsa-plugins pulseaudio pulseaudio-alsa pulseaudio-bluetooth jgmenu
	Загрузка конфигов:
		git clone https://github.com/drain47/tile_workspace.git
		cd tile_workspace



####  SETUP BLACKARCH  ####
	sudo rm -rf /etc/pacman.d/gnupg
	sudo pacman-key --init
	sudo pacman-key --populate
	sudo pacman-key --update
	curl -O https://blackarch.org/strap.sh
	chmod +x strap.sh
	sha1sum strap.sh
	sed -i "s|pgp.mit.edu|18.9.60.141|g" strap.sh
	sh strap.sh
	pacman -Syy


####  INSTALLING AUR PACKAGES  ####
	pacman -S --needed base-devel
	sudo pacman -S git
	git clone https://aur.archlinux.org/имя_пакета.git
	cd имя_пакета
	makepkg -si --skippgpcheck


####  FAQ URLs  ####
	kali.org.ru/main-forum/blackarch/  -  BlackArch
	ziggi.org/ustanovka-i-nastroyka-arch-linux-xfce-chast-1/  - Arch Install
	https://hackware.ru/?p=6398  -  Arch Install (new)
	http://dotshare.it/ - Config Collection
	https://habr.com/ru/articles/721112/ - bspwm install
	https://habr.com/ru/articles/269967/ - bashrc
	https://github.com/polybar/polybar-scripts/tree/master - polybar scripts
 	https://losst.pro/nastrojka-zsh-i-oh-my-zsh - zsh settings
  	https://habr.com/ru/companies/ruvds/articles/325522/ - coding bash scripts
