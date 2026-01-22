from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.by import By
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import countryflag
import sys


def get_table_markdown(url: str, max_players: int = 25, with_tb: bool = False):
    markdown_table = '| Place | Player               | Score |\n' \
    '| ----- | --------------------- | ----- |\n'
    markdown_table_with_tiebreak = '| Place | Player               | TB    | Score |\n' \
    '| ----- | --------------------- | ----- | ----- |\n'

    if with_tb:
        markdown_table = markdown_table_with_tiebreak

    options = webdriver.ChromeOptions()
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')

    driver = webdriver.Chrome(options=options)
    driver.get(url)

    table_classes = '.crosstable-swiss-component, .crosstable-standard-component'

    wait = WebDriverWait(driver=driver, timeout=120)
    wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, table_classes)))
    wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, '.country-flags-component')))
    time.sleep(3)
    actions = ActionChains(driver=driver)

    table = driver.find_element(By.CSS_SELECTOR, table_classes)
    rows = table.find_elements(By.CSS_SELECTOR, 'tbody tr')
    for row in rows[:max_players]:
        cells = row.find_elements(By.CSS_SELECTOR, 'td')[:5]
        if len(cells) > 0:
            actions.move_to_element(cells[4]).perform()
            tiebreak_popover = wait.until(
                EC.visibility_of_element_located((By.CSS_SELECTOR, '.cc-tooltip-component'))
            )
            actions.reset_actions()
            if tiebreak_popover:
                tiebreak_points = tiebreak_popover.text.split()[1]

            try:
                country_code = cells[2].find_element(By.CSS_SELECTOR, 'div').get_attribute('class').split()[1].replace('country-', '').upper().replace('XX', 'RU')
            except NoSuchElementException:
                country_code = 'RU'

            country_emoji = countryflag.getflag(countries=country_code)

            player_title_name = cells[1].find_elements(By.CSS_SELECTOR, 'span')

            markdown_table_row = f'| {cells[0].text}. | {country_emoji} {player_title_name[0].text.strip()} {player_title_name[1].text} {f'| {tiebreak_points} |' if with_tb else ' |'} {cells[4].text} |\n'
            markdown_table += markdown_table_row

    driver.quit()
    return markdown_table
        

if __name__ == '__main__':
    args = sys.argv[1:]

    if not ('--url' in args):
        print('You forgot "--url **URL**"!')
    else:
        url = args[args.index('--url') + 1]
        max_players = int(args[args.index('--max') + 1]) + 1
        with_tb = '--tb' in args

        print(get_table_markdown(url=url, with_tb=with_tb, max_players=max_players))