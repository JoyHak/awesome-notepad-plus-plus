from Npp import (
    editor, notepad,
    SCINTILLANOTIFICATION, NOTIFICATION
)

from os.path import join as join_path, isfile
from time import sleep
from lxml.etree import fromstring as decode_xml
import re 

autocompl_dir = join_path(notepad.getNppDir(), 'autoCompletion')
lang_data = None
langs = {}

def get_lang_data(args):
    """Gets auto completion .xml file data for current language."""
    global autocompl_dir, lang_data, langs
    
    lang_type = notepad.getLangType(args['bufferID'])
    lang_name = notepad.getLanguageName(lang_type)

    if ' - ' in lang_name:
        # It's UDF language
        lang_name = lang_name.split(' - ')[-1]

    if langs.get(lang_name):
        lang_data = langs.get(lang_name)
        return        

    filepath = join_path(autocompl_dir, lang_name + '.xml')           
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            lang_data = f.read()
            langs[lang_name] = lang_data
            return
    except:
        lang_data = None                


def wrap_text(text, width = 110):
    """Wraps long text line by line."""
    
    from textwrap import TextWrapper    
    wrap_text.wrapper = TextWrapper(
        width = width, 
        break_long_words = False, 
        replace_whitespace = False
    )
    
    lines = ''
    for line in text.splitlines():
        lines += wrap_text.wrapper.fill(line) + '\n'
    
    return lines.strip()
    

class DWELL_TIME:
    SHORT = 100
    NORMAL = 500
    DISABLE = 10000000
    
class RE_PATTERN:
    OVERLOAD = re.compile(r'<Overload[^>]*retVal="([^"]*)"[^>]*descr="([^"]*)"[^>]*\/?>(?:(.*?)<\/Overload>)?', re.DOTALL)
    PARAM = re.compile(r'<Param name="([^"]*)"/>')

class calltip:
    pages = []
    current_page = 0
    pos = 0
    x = 0
    y = 0

def cancel_calltip(args): 
    # if calltip.x != args['x'] or calltip.y != args['y']:
    editor.callTipCancel()

def show_calltip(args):
    """Displays calltip (function signature and description) near caret position."""
    global lang_data, calltip

    if not lang_data:
        return None
    
    # Get current word   
    # print("start", args)
    calltip.pos = pos = args['position']
    calltip.x = args['x']
    calltip.y = args['y']
    calltip.pages = []
    
    search_word = editor.getTextRangeFull(
        editor.wordStartPosition(pos, True), 
        editor.wordEndPosition(pos, True)
    )
    
    # Search for tag with selected word
    keyword = None   
    for variant in [search_word, f"#{search_word}", f"<{search_word}>", f"%{search_word}%"]:
        keyword = re.search(
            rf'<KeyWord name="({re.escape(variant)})"(?:\s+func="(.*?)")?[^>]*>(.*?)</KeyWord>', 
            lang_data, 
            re.DOTALL | re.IGNORECASE
        )
        if keyword:
            break

    if not keyword:
        return None
    
    name = keyword.group(1)
    is_func = keyword.group(2) == 'yes'
    overloads = keyword.group(3)
    
    # Find tags with paremeters and description
    overloads = list(RE_PATTERN.OVERLOAD.finditer(overloads))  
    if not overloads:
        return None

    # Create separate calltip page for each Overload
    is_multipage = len(overloads) > 1
    for i, overload in enumerate(overloads):
        retval, descr, _params = overload.groups()
        descr = descr.strip()
        
        params = ''
        if is_func:
            if not retval:
                retval = '{void}'
            
            if _params:
                # Extract parameters names
                params = RE_PATTERN.PARAM.findall(_params)            
                params = ', '.join(params)
                params = f"({params})"

        # Create pages
        page      = f"{i+1} of {len(overloads)}\x02 (click to switch)\n" if is_multipage else ''
        signature = f"{retval} {name}{params}\n\n{descr}".strip()
        
        try:
            signature = page + decode_xml(f"""<text>{signature}</text>""").text
        except:
            signature = page + signature
            
        calltip.pages.append(wrap_text(signature))
    
    if calltip.pages:        
        # Temporarily disable mouse movement processing because callTipShow() 
        # may cause a loop due to sending DWELLSTART messages
        editor.setMouseDwellTime(DWELL_TIME.DISABLE)

        calltip.current_page = 0  # Start with first page
        editor.callTipShow(calltip.pos, calltip.pages[calltip.current_page])
        
        sleep(0.3)
        editor.setMouseDwellTime(DWELL_TIME.NORMAL)

def calltip_next_page(args):
    """Сycles through overload pages created by show_calltip."""
    global calltip
    
    if not calltip.pages or not calltip.pos:
        return
    
    # Cycle to next page: 0->1->2->0
    calltip.current_page = (calltip.current_page + 1) % len(calltip.pages)
    current_calltip = calltip.pages[calltip.current_page]

    editor.callTipShow(calltip.pos, current_calltip)


print('Calltips is activated')

# Initial auto сompletion
get_lang_data({'bufferID': notepad.getCurrentBufferID()})
notepad.clearCallbacks()
notepad.callback(get_lang_data, [NOTIFICATION.LANGCHANGED, NOTIFICATION.BUFFERACTIVATED])

# Mouse movement
editor.clearCallbacks()
editor.setMouseDwellTime(DWELL_TIME.NORMAL)
editor.callback(show_calltip, [SCINTILLANOTIFICATION.DWELLSTART])
# editor.callback(cancel_calltip, [SCINTILLANOTIFICATION.DWELLEND, SCINTILLANOTIFICATION.UPDATEUI])
editor.callback(calltip_next_page, [SCINTILLANOTIFICATION.CALLTIPCLICK])