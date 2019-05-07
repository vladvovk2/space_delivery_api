$(document).on('turbolinks:load', function(){
  var sliderContainer1 = $('.ingredients-sliders-container .ingredient-content-wrapper');
  var ingredArr = [];

  var slidePositions = [
    -787.5, -630, -471.605, -315, -157.5, 0, 157.5, 315, 471.605, 630, 787.5
  ];
  var slidePositionIndx = 5;

  //fillArrWithIngredients(ingredArr);

  var sliderContainer = document.getElementsByClassName("ingredients-sliders-container");
  var sliderContainerWidth = (ingredArr.length * 157.5);
  //sliderContainer[0].style.width = sliderContainerWidth + "px";

  var sliderContainer1 = $('.ingredients-sliders-container');
  console.log(sliderContainer1.children());
  if (sliderContainer1.children().length < 5) {
    //sliderContainer.style.left = 'initial';

    $('.prev, .next').css('display', 'none');

    console.log(sliderContainer1.children().length);

    var widthPercent = 100 / sliderContainer1.children().length
    $('.ingredient-content-wrapper').css('width', widthPercent + "%");
    //remove arrows.
    //remove left offset
    //don't set ingredient container width equal to element size

  }

  //console.log((sliderContainerWidth - 157.5) +'px');
  // ingredArr[ingredArr.length - 1].style.left = 'initial';
  // ingredArr[ingredArr.length - 1].style.right = (sliderContainerWidth - 157.5) +'px'; 

  // function fillArrWithIngredients(ingredArr) {
  //   var ingredients = document.getElementsByClassName("ingredient-content-wrapper");

  //   for (var i = 0; i < ingredients.length; i++) {
  //     ingredArr[i] = ingredients[i];
  //   }
  // }


  // console.log(ingredArr);

  // function setEdgeElementsPosition() {
  //   ingredArr[ingredArr.length - 1].style.position = 'absolute';
  //   ingredArr[ingredArr.length - 1].style.top = '0';
  //   ingredArr[ingredArr.length - 1].style.left = 'initial';
  //   ingredArr[ingredArr.length - 1].style.right = '634px';

  //   ingredArr[4].style.position = 'absolute';
  //   ingredArr[4].style.top = '0';
  //   ingredArr[4].style.left = 'initial';
  //   ingredArr[4].style.right = '-153px';
  // }

  // function setRightOrLeftElement(n) {
  //   if (n + 1) {
  //     ingredArr[ingredArr.length - 1].style.position = 'absolute';
  //     ingredArr[ingredArr.length - 1].style.top = '0';
  //     ingredArr[ingredArr.length - 1].style.left = 'initial';
  //     ingredArr[ingredArr.length - 1].style.right = '634px';    
  //   } else {
  //     ingredArr[4].style.position = 'absolute';
  //     ingredArr[4].style.top = '0';
  //     ingredArr[4].style.left = 'initial';
  //     ingredArr[4].style.right = '-153px';
  //   }
  // }

  // function moveArrItems(n) {
  //   if (n + 1) {
  //     ingredArr.unshift(ingredArr.pop());    
  //   } else {
  //     ingredArr.push(ingredArr.shift());
  //   }
  // }

  // function moveSlides(n) {

  //   // if (n + 1) {
  //   //   ingredArr[ingredArr.length - 1].style.left = 'initial';
  //   //   ingredArr[ingredArr.length - 1].style.right = '634px'; 
  //   // }
    

  //   slidePositionIndx += n;
  //   var slidePosition = slidePositions[slidePositionIndx];
    
  //   for (var i = 0; i < ingredArr.length; i++) {
  //     ingredArr[i].style.left = slidePosition + "px";
  //   }
  //   moveArrItems(n);

  //   console.log(ingredArr);
  // }
});

