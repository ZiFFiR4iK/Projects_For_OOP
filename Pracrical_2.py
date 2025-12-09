import xml.etree.ElementTree as ET
import csv
import time
import os
from collections import defaultdict
from pathlib import Path


class AddressProcessor:
    """Обработчик файлов адресов (XML и CSV)"""
    
    def __init__(self):
        self.addresses = defaultdict(int)
        self.city_floors = defaultdict(lambda: defaultdict(int))
        self.processing_time = 0
        
    def process_xml(self, file_path):
        """Обработка XML файла"""
        start_time = time.time()
        
        try:
            context = ET.iterparse(file_path, events=('end',))
            
            for event, elem in context:
                if elem.tag == 'item':
                    city = elem.get('city', '')
                    street = elem.get('street', '')
                    house = elem.get('house', '')
                    floor = elem.get('floor', '')
                    
                    if city and street and house and floor:
                        key = (city, street, house, floor)
                        self.addresses[key] += 1
                        self.city_floors[city][int(floor)] += 1
                    
                    elem.clear()
            
            self.processing_time = time.time() - start_time
            return True, None
            
        except FileNotFoundError:
            return False, f"Файл не найден: {file_path}"
        except ET.ParseError as e:
            return False, f"Ошибка парсинга XML: {str(e)}"
        except Exception as e:
            return False, f"Ошибка: {str(e)}"
    
    def process_csv(self, file_path):
        """Обработка CSV файла"""
        start_time = time.time()
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                next(f)
                reader = csv.reader(f, delimiter=';')
                
                for row in reader:
                    if len(row) >= 4:
                        city = row[0].strip().strip('"')
                        street = row[1].strip().strip('"')
                        house = row[2].strip().strip('"')
                        floor = row[3].strip().strip('"')
                        
                        if city and street and house and floor:
                            key = (city, street, house, floor)
                            self.addresses[key] += 1
                            
                            try:
                                floor_int = int(floor)
                                self.city_floors[city][floor_int] += 1
                            except ValueError:
                                pass
            
            self.processing_time = time.time() - start_time
            return True, None
            
        except FileNotFoundError:
            return False, f"Файл не найден: {file_path}"
        except Exception as e:
            return False, f"Ошибка: {str(e)}"
    
    def print_statistics(self):
        """Вывод статистики"""
        print("\n" + "="*80)
        print("СТАТИСТИКА")
        print("="*80)
        
        # Дублирующиеся записи
        print("\n1. Дублирующиеся записи:")
        duplicates = [(addr, count) for addr, count in self.addresses.items() if count > 1]
        duplicates.sort(key=lambda x: x[1], reverse=True)
        
        if duplicates:
            for (city, street, house, floor), count in duplicates[:20]:
                print(f"   {city} | {street} | дом {house}, этаж {floor} → {count} раз(а)")
            if len(duplicates) > 20:
                print(f"   ... и ещё {len(duplicates) - 20}")
        else:
            print("   Нет дублей")
        
        # Статистика по этажам
        print("\n2. Здания по этажам в каждом городе:")
        for city in sorted(self.city_floors.keys())[:10]:
            print(f"\n   {city}:")
            for floor in [1, 2, 3, 4, 5]:
                count = self.city_floors[city].get(floor, 0)
                if count > 0:
                    print(f"      {floor} этаж: {count}")
        
        if len(self.city_floors) > 10:
            print(f"\n   ... и ещё {len(self.city_floors) - 10} городов")
        
        # Время обработки
        print("\n3. Время обработки:")
        print(f"   {self.processing_time:.2f} сек")
        print(f"   Обработано записей: {len(self.addresses)}")
        print("="*80 + "\n")
    
    def clear(self):
        """Очистка данных"""
        self.addresses.clear()
        self.city_floors.clear()
        self.processing_time = 0


def main():
    """Главная функция"""
    processor = AddressProcessor()
    
    print("\n" + "="*80)
    print("ОБРАБОТЧИК ФАЙЛОВ АДРЕСОВ")
    print("="*80)
    print("Команды: введите путь до файла (*.xml или *.csv)")
    print("         или 'exit' для выхода")
    print("="*80 + "\n")
    
    while True:
        try:
            file_path = input("Путь до файла > ").strip()
            
            if file_path.lower() in ('exit', 'quit'):
                print("Выход.")
                break
            
            if not file_path:
                print("Ошибка: введите путь\n")
                continue
            
            if not os.path.exists(file_path):
                print(f"Ошибка: файл не найден\n")
                continue
            
            processor.clear()
            
            file_ext = Path(file_path).suffix.lower()
            
            if file_ext == '.xml':
                success, error = processor.process_xml(file_path)
            elif file_ext == '.csv':
                success, error = processor.process_csv(file_path)
            else:
                print("Ошибка: только .xml или .csv\n")
                continue
            
            if not success:
                print(f"Ошибка: {error}\n")
                continue
            
            processor.print_statistics()
            
        except KeyboardInterrupt:
            print("\n\nВыход.")
            break
        except Exception as e:
            print(f"Ошибка: {str(e)}\n")


if __name__ == "__main__":
    main()