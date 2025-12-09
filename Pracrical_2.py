import xml.etree.ElementTree as ET
import csv
import time
import os
from collections import defaultdict
from pathlib import Path


class AddressProcessor:

    def __init__(self):
        # Словарь вида {(city, street, house, floor): count}
        self.addresses = defaultdict(int)

        # Вложенный словарь вида {city: {floor: count}}, для каждого города считаем здания
        self.city_floors = defaultdict(lambda: defaultdict(int))

        # Время обработки текущего файла (секунды)
        self.processing_time = 0

    def process_xml(self, file_path: str):
        """
        Обработка XML-файла с адресами.
        """
        start_time = time.time()

        try:
            # iterparse обрабатывает файл по мере чтения
            context = ET.iterparse(file_path, events=('end',))

            for event, elem in context:
                # Нас интересуют только элементы <item>
                if elem.tag == 'item':
                    city = elem.get('city', '')
                    street = elem.get('street', '')
                    house = elem.get('house', '')
                    floor = elem.get('floor', '')

                    # Проверяем, что все поля заполнены
                    if city and street and house and floor:
                        key = (city, street, house, floor)
                        self.addresses[key] += 1

                        # Считаем статистику по этажам
                        try:
                            floor_int = int(floor)
                            self.city_floors[city][floor_int] += 1
                        except ValueError:
                            # Если этаж не число — пропускаем
                            pass

                    # Обязательно очищаем элемент, чтобы не копить его в памяти
                    elem.clear()

            self.processing_time = time.time() - start_time
            return True, None

        except FileNotFoundError:
            return False, f"Файл не найден: {file_path}"
        except ET.ParseError as e:
            return False, f"Ошибка парсинга XML: {e}"
        except Exception as e:
            return False, f"Неожиданная ошибка при обработке XML: {e}"

    def process_csv(self, file_path: str):
        """
        Обработка CSV-файла с адресами.
        """
        start_time = time.time()

        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                # Пропускаем строку с заголовком
                next(f)

                reader = csv.reader(f, delimiter=';')

                for row in reader:
                    # Строка должна содержать минимум 4 столбца
                    if len(row) < 4:
                        continue

                    # Убираем пробелы по краям и возможные кавычки
                    city = row[0].strip().strip('"')
                    street = row[1].strip().strip('"')
                    house = row[2].strip().strip('"')
                    floor = row[3].strip().strip('"')

                    if city and street and house and floor:
                        key = (city, street, house, floor)
                        self.addresses[key] += 1

                        # Пытаемся интерпретировать этаж как целое число
                        try:
                            floor_int = int(floor)
                            self.city_floors[city][floor_int] += 1
                        except ValueError:
                            # Некорректное значение этажа просто игнорируем
                            pass

            self.processing_time = time.time() - start_time
            return True, None

        except FileNotFoundError:
            return False, f"Файл не найден: {file_path}"
        except Exception as e:
            return False, f"Неожиданная ошибка при обработке CSV: {e}"

    def _get_duplicates(self):
        """
        Внутренний метод: формирует список дубликатов.
        """
        duplicates = [
            (addr, count)
            for addr, count in self.addresses.items()
            if count > 1
        ]
        duplicates.sort(key=lambda x: x[1], reverse=True)
        return duplicates

    def print_statistics(self):
        """
        Печатает сводную статистику по обработанному файлу:
          1) дублирующиеся записи;
          2) количество 1–5‑этажных зданий по городам;
          3) время обработки и количество записей.
        """
        print("\n" + "=" * 80)
        print("РЕЗУЛЬТАТ ОБРАБОТКИ ФАЙЛА")
        print("=" * 80)

        # ---------- 1. Дублирующиеся записи ----------
        print("\n[1] Дублирующиеся записи")
        print("-" * 80)

        duplicates = self._get_duplicates()

        if duplicates:
            print("Показаны первые 20 дублей (если их больше):\n")
            for (city, street, house, floor), count in duplicates[:20]:
                print(f"  {city} | {street} | дом {house}, этаж {floor}  →  {count} раз(а)")
            if len(duplicates) > 20:
                print(f"\n  ... и ещё {len(duplicates) - 20} записей")
        else:
            print("  Дублирующихся записей не найдено")

        # ---------- 2. Статистика по этажам ----------
        print("\n[2] Количество зданий по этажам в каждом городе")
        print("-" * 80)

        if not self.city_floors:
            print("  Нет данных по этажам.")
        else:
            print("Показаны первые 10 городов в алфавитном порядке:\n")
            for city in sorted(self.city_floors.keys())[:10]:
                print(f"  {city}:")
                for floor in [1, 2, 3, 4, 5]:
                    count = self.city_floors[city].get(floor, 0)
                    print(f"    {floor} этаж: {count} зданий")
                print()

            total_cities = len(self.city_floors)
            if total_cities > 10:
                print(f"  ... и ещё {total_cities - 10} городов")

        # ---------- 3. Время обработки ----------
        print("\n[3] Время обработки и объём данных")
        print("-" * 80)
        print(f"  Время обработки: {self.processing_time:.2f} сек")
        print(f"  Обработано уникальных адресов: {len(self.addresses)}")
        print("=" * 80 + "\n")

    def clear(self):
        """
        Очищает внутреннее состояние, чтобы можно было
        обработать новый файл тем же экземпляром класса.
        """
        self.addresses.clear()
        self.city_floors.clear()
        self.processing_time = 0


def main():
    
    processor = AddressProcessor()

    print("\n" + "=" * 80)
    print("КОНСОЛЬНЫЙ ОБРАБОТЧИК ФАЙЛОВ АДРЕСОВ (XML / CSV)")
    print("=" * 80)
    print("Как пользоваться:")
    print("  1) Введите полный или относительный путь к файлу справочника.")
    print("  2) Поддерживаемые форматы: .xml, .csv")
    print("  3) Для выхода введите: exit, quit или q")
    print("=" * 80 + "\n")

    while True:
        try:
            file_path = input("Введите путь до файла (или команду выхода) > ").strip()

            # Команда выхода
            if file_path.lower() in ("exit", "quit", "q"):
                print("\nЗавершение работы программы.")
                break

            # Пустой ввод
            if not file_path:
                print("Ошибка: путь не может быть пустым.\n")
                continue

            # Проверка существования файла
            if not os.path.exists(file_path):
                print(f"Ошибка: файл не найден по пути: {file_path}\n")
                continue

            # Очищаем данные от предыдущего файла
            processor.clear()

            # Определяем расширение файла
            file_ext = Path(file_path).suffix.lower()

            if file_ext == ".xml":
                print("\nОбработка XML-файла, пожалуйста, подождите...")
                success, error = processor.process_xml(file_path)
            elif file_ext == ".csv":
                print("\nОбработка CSV-файла, пожалуйста, подождите...")
                success, error = processor.process_csv(file_path)
            else:
                print("Ошибка: поддерживаются только файлы с расширением .xml или .csv.\n")
                continue

            # Проверяем результат обработки
            if not success:
                print(f"Ошибка при обработке файла: {error}\n")
                continue

            # Выводим собранную статистику
            processor.print_statistics()

        except KeyboardInterrupt:
            # Обработка Ctrl+C — корректный выход
            print("\n\nПрограмма прервана пользователем (Ctrl+C).")
            break
        except Exception as e:
            # На всякий случай ловим любые непредвиденные ошибки,
            # чтобы приложение не падало
            print(f"Непредвиденная ошибка: {e}\n")


if __name__ == "__main__":
    main()