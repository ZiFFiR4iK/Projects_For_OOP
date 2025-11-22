# -*- coding: windows-1251 -*-
import urllib.parse
import urllib.request
import json
import webbrowser

class WikipediaSearcher:
    def __init__(self):
        self.BASE_URL = "https://ru.wikipedia.org/w/api.php"

    def get_user_input(self):
        return input("Введите поисковый запрос: ").strip()

    def encode_query(self, query):
        return urllib.parse.quote(query)

    def make_request(self, encoded_query, search_type="standard"):
        """Разные типы поиска для лучших результатов"""
        if search_type == "exact":
            # Поиск по точному заголовку
            url = f"https://ru.wikipedia.org/w/api.php?action=query&format=json&titles={encoded_query}"
        elif search_type == "suggest":
            # Поиск через API подсказок (как в поисковой строке на сайте)
            url = f"https://ru.wikipedia.org/w/api.php?action=opensearch&format=json&search={encoded_query}&limit=10"
        else:
            # Стандартный поиск
            params = {
                'action': 'query',
                'list': 'search',
                'format': 'json',
                'srsearch': encoded_query,
                'srlimit': 10,
                'srprop': 'size'  # Добавляем информацию о размере статьи
            }
            url = f"{self.BASE_URL}?{urllib.parse.urlencode(params)}"
        
        req = urllib.request.Request(
            url,
            headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'}
        )
        
        with urllib.request.urlopen(req) as response:
            return json.loads(response.read().decode())

    def parse_results(self, data, search_type="standard"):
        if search_type == "suggest":
            # Обработка ответа от opensearch API
            if len(data) >= 2:
                titles = data[1]
                urls = data[3]
                results = []
                for i, title in enumerate(titles):
                    # Извлекаем pageid из URL
                    pageid = None
                    if i < len(urls):
                        # Пытаемся извлечь pageid из URL
                        url_parts = urls[i].split('curid=')
                        if len(url_parts) > 1:
                            pageid = url_parts[1]
                        else:
                            # Если нет curid, используем заголовок для формирования URL
                            pageid = title
                    results.append({
                        'title': title,
                        'pageid': pageid
                    })
                return results
            return []
        
        if search_type == "exact":
            # Обработка точного поиска по заголовку
            if 'query' in data and 'pages' in data['query']:
                pages = data['query']['pages']
                results = []
                for pageid, pageinfo in pages.items():
                    if pageid != '-1':  # -1 означает, что страница не найдена
                        results.append({
                            'title': pageinfo['title'],
                            'pageid': pageid
                        })
                return results
            return []
        
        # Стандартный поиск
        if 'query' not in data or 'search' not in data['query']:
            return []
        
        search_info = data.get('query', {}).get('searchinfo', {})
        total_hits = search_info.get('totalhits', 0)
        print(f"Найдено статей: {total_hits}")
        
        results = []
        for item in data['query']['search']:
            results.append({
                'title': item['title'],
                'pageid': item['pageid']
            })
        
        return results

    def search_wikipedia(self, query):
        """Пробуем разные методы поиска"""
        encoded_query = self.encode_query(query)
        
        # Сначала пробуем точный поиск по заголовку
        print("Пробуем точный поиск...")
        exact_data = self.make_request(encoded_query, "exact")
        exact_results = self.parse_results(exact_data, "exact")
        
        if exact_results:
            return exact_results
        
        # Если точный поиск не дал результатов, пробуем поиск с подсказками
        print("Пробуем поиск с подсказками...")
        suggest_data = self.make_request(encoded_query, "suggest")
        suggest_results = self.parse_results(suggest_data, "suggest")
        
        if suggest_results:
            return suggest_results
        
        # Если и это не помогло, используем стандартный поиск
        print("Пробуем стандартный поиск...")
        standard_data = self.make_request(encoded_query, "standard")
        return self.parse_results(standard_data, "standard")

    def display_results(self, results):
        if not results:
            print("По вашему запросу ничего не найдено.")
            return False

        print(f"\nРезультаты поиска:")
        print("-" * 40)
        
        for i, item in enumerate(results, 1):
            print(f"{i}. {item['title']}")
        
        print("-" * 40)
        return True

    def select_article(self, results):
        while True:
            try:
                choice = input("\nВведите номер статьи для открытия (или 'q' для выхода): ").strip()
                if choice.lower() == 'q':
                    return None
                choice = int(choice)
                if 1 <= choice <= len(results):
                    return results[choice-1]['pageid']
                print(f"Пожалуйста, введите число от 1 до {len(results)}")
            except ValueError:
                print("Пожалуйста, введите число.")

    def open_in_browser(self, pageid, title=None):
        if pageid is None:
            return
        
        # Формируем URL разными способами в зависимости от того, что у нас есть
        if pageid.isdigit() or (pageid[0] == '-' and pageid[1:].isdigit()):
            # Если pageid - число, используем curid
            url = f"https://ru.wikipedia.org/w/index.php?curid={pageid}"
        else:
            # Если pageid - это текст (заголовок), используем его для формирования URL
            encoded_title = self.encode_query(pageid)
            url = f"https://ru.wikipedia.org/wiki/{encoded_title}"
        
        print(f"Открываю статью в браузере...")
        webbrowser.open(url)

    def run(self):
        try:
            query = self.get_user_input()
            if not query:
                print("Запрос не может быть пустым.")
                return

            results = self.search_wikipedia(query)

            if self.display_results(results):
                pageid = self.select_article(results)
                self.open_in_browser(pageid)
            else:
                print("Попробуйте изменить поисковый запрос.")

        except Exception as e:
            print(f"Произошла ошибка: {e}")

if __name__ == "__main__":
    searcher = WikipediaSearcher()
    searcher.run()