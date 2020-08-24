class JobCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' }, { id: 2, name: 'デザイナー' }, { id: 3, name: 'ライター' }, { id: 4, name: 'マーケター' },
    { id: 5, name: 'インフルエンサー' }, { id: 6, name: 'Web制作' }, { id: 7, name: 'ITエンジニア' }
  ]
end

