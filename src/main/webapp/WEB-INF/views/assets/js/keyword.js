// 변수 선언 -> init 호출 -> loadKeywords

const searchForm = document.querySelector("#searchForm"),
searchBtn = document.querySelector("#searchBtn"),
keywordInput = searchForm.querySelector("#keyword"),
keywordList = document.querySelector("#l-key");

const KEYWORD_LS = 'keyword';

let keyword = [];

function deleteKeyword(event){
  const btn = event.target;
  const li = btn.parentNode;
  keywordList.removeChild(li);
  const cleanKeywords = keyword.filter(function(keyword){
    return keyword.id !== parseInt(li.id);
  });
  keyword = cleanKeywords;
  saveKeyword();
}

function saveKeyword(){
  localStorage.setItem(KEYWORD_LS, JSON.stringify(keyword));
}

function paintKeyword(text){
  const li = document.createElement("li");
  const delBtn = document.createElement("button");
  const span = document.createElement("span");
  const newId = keyword.length % 10;		
  delBtn.innerText = '❌';
  delBtn.addEventListener("click", deleteKeyword);
  span.innerText = text;
  li.appendChild(delBtn);
  li.appendChild(span);
  li.id = newId;
  keywordList.appendChild(li);
  const keywordObj = {
    text: text,
    id: newId
  };
  keyword.push(keywordObj);
  saveKeyword();
}

function handleSubmit(event){
  event.preventDefault();
  const currentValue = keywordInput.value;
	if (keyword.length < 10) {
	  paintKeyword(currentValue);
	  keywordInput.value = "";
	}
}


// 2. 로컬스토리지에서 아이템 가져오기
function loadKeywords(){
  const loadedKeywords = localStorage.getItem(KEYWORD_LS);
  if(loadedKeywords !== null){
    const parsedKeywords = JSON.parse(loadedKeywords);
    parsedKeywords.forEach(function(keyword){
      paintKeyword(keyword.text);
    });
  }
}

// 1.호출
function init(){
  loadKeywords();
  searchBtn.addEventListener("click", handleSubmit);
}
init();