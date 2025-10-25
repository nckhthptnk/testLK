<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Học Vật Lý Lớp 11</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            box-sizing: border-box;
        }
        .formula-card {
            transition: all 0.3s ease;
        }
        .formula-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .tab-active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .progress-bar {
            transition: width 0.5s ease;
        }
        .quiz-option {
            transition: all 0.2s ease;
        }
        .quiz-option:hover {
            background-color: #f3f4f6;
        }
        .quiz-correct {
            background-color: #d1fae5 !important;
            border-color: #10b981 !important;
        }
        .quiz-incorrect {
            background-color: #fee2e2 !important;
            border-color: #ef4444 !important;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-indigo-100 min-h-full">
    <header class="bg-white shadow-lg">
        <div class="max-w-6xl mx-auto px-4 py-6">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <div class="w-12 h-12 bg-gradient-to-r from-blue-500 to-purple-600 rounded-lg flex items-center justify-center">
                        <span class="text-white text-xl font-bold">⚡</span>
                    </div>
                    <div>
                        <h1 class="text-2xl font-bold text-gray-800">Vật Lý Lớp 11</h1>
                        <p class="text-gray-600 text-sm">Học công thức và lý thuyết hiệu quả</p>
                    </div>
                </div>
                <div class="flex items-center space-x-4">
                    <div class="text-right">
                        <p class="text-sm text-gray-600">Tiến độ học tập</p>
                        <div class="w-32 h-2 bg-gray-200 rounded-full mt-1">
                            <div id="progressBar" class="progress-bar h-2 bg-gradient-to-r from-green-400 to-blue-500 rounded-full" style="width: 0%"></div>
                        </div>
                    </div>
                    <span id="progressText" class="text-lg font-semibold text-gray-700">0%</span>
                </div>
            </div>
        </div>
    </header>

    <main class="max-w-6xl mx-auto px-4 py-8">
        <!-- Navigation Tabs -->
        <div class="flex flex-wrap gap-2 mb-8 bg-white p-2 rounded-xl shadow-md">
            <button onclick="showTab('formulas')" id="tab-formulas" class="tab-active px-6 py-3 rounded-lg font-medium transition-all">
                📐 Công Thức
            </button>
            <button onclick="showTab('theory')" id="tab-theory" class="px-6 py-3 rounded-lg font-medium text-gray-600 hover:bg-gray-100 transition-all">
                📚 Lý Thuyết
            </button>
            <button onclick="showTab('quiz')" id="tab-quiz" class="px-6 py-3 rounded-lg font-medium text-gray-600 hover:bg-gray-100 transition-all">
                🧠 Kiểm Tra
            </button>
            <button onclick="showTab('calculator')" id="tab-calculator" class="px-6 py-3 rounded-lg font-medium text-gray-600 hover:bg-gray-100 transition-all">
                🔢 Máy Tính
            </button>
        </div>

        <!-- Formulas Tab -->
        <div id="formulas-content" class="tab-content">
            <div class="mb-6">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-2xl font-bold text-gray-800">Công Thức Vật Lý Lớp 11</h2>
                    <button onclick="showAddFormulaModal()" class="bg-green-500 text-white px-4 py-2 rounded-lg font-medium hover:bg-green-600 transition-all flex items-center gap-2">
                        ➕ Thêm Công Thức
                    </button>
                </div>
                <div class="flex flex-wrap gap-2 mb-6">
                    <button onclick="filterFormulas('all')" class="filter-btn bg-blue-500 text-white px-4 py-2 rounded-lg font-medium">Tất Cả</button>
                    <button onclick="filterFormulas('mechanics')" class="filter-btn bg-gray-200 text-gray-700 px-4 py-2 rounded-lg font-medium hover:bg-gray-300">Cơ Học</button>
                    <button onclick="filterFormulas('thermodynamics')" class="filter-btn bg-gray-200 text-gray-700 px-4 py-2 rounded-lg font-medium hover:bg-gray-300">Nhiệt Học</button>
                    <button onclick="filterFormulas('electricity')" class="filter-btn bg-gray-200 text-gray-700 px-4 py-2 rounded-lg font-medium hover:bg-gray-300">Điện Học</button>
                    <button onclick="filterFormulas('custom')" class="filter-btn bg-gray-200 text-gray-700 px-4 py-2 rounded-lg font-medium hover:bg-gray-300">Của Tôi</button>
                </div>
            </div>

            <div id="formulas-grid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <!-- Formulas will be populated by JavaScript -->
            </div>
        </div>

        <!-- Theory Tab -->
        <div id="theory-content" class="tab-content hidden">
            <h2 class="text-2xl font-bold text-gray-800 mb-6">Lý Thuyết Vật Lý Lớp 11</h2>
            <div class="space-y-6">
                <div class="bg-white rounded-xl shadow-md p-6">
                    <h3 class="text-xl font-bold text-blue-600 mb-4">🔄 Dao Động Cơ</h3>
                    <div class="space-y-3 text-gray-700">
                        <p><strong>Định nghĩa:</strong> Dao động cơ là chuyển động qua lại của vật quanh vị trí cân bằng.</p>
                        <p><strong>Đặc điểm:</strong> Có tính tuần hoàn, lặp lại sau những khoảng thời gian bằng nhau.</p>
                        <p><strong>Các đại lượng:</strong></p>
                        <ul class="list-disc list-inside ml-4 space-y-1">
                            <li>Biên độ A: Độ lệch cực đại khỏi vị trí cân bằng</li>
                            <li>Chu kì T: Thời gian thực hiện một dao động toàn phần</li>
                            <li>Tần số f: Số dao động thực hiện trong 1 giây</li>
                        </ul>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-md p-6">
                    <h3 class="text-xl font-bold text-green-600 mb-4">🌡️ Nhiệt Động Học</h3>
                    <div class="space-y-3 text-gray-700">
                        <p><strong>Nguyên lý I:</strong> Độ biến thiên nội năng của hệ bằng tổng công và nhiệt lượng mà hệ nhận được.</p>
                        <p><strong>Công thức:</strong> ΔU = A + Q</p>
                        <p><strong>Quá trình đẳng nhiệt:</strong> T = const, ΔU = 0, A = -Q</p>
                        <p><strong>Quá trình đẳng tích:</strong> V = const, A = 0, ΔU = Q</p>
                        <p><strong>Quá trình đẳng áp:</strong> p = const, A = p.ΔV</p>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-md p-6">
                    <h3 class="text-xl font-bold text-purple-600 mb-4">⚡ Điện Học</h3>
                    <div class="space-y-3 text-gray-700">
                        <p><strong>Định luật Ohm:</strong> Cường độ dòng điện tỉ lệ thuận với hiệu điện thế và tỉ lệ nghịch với điện trở.</p>
                        <p><strong>Công suất điện:</strong> P = UI = I²R = U²/R</p>
                        <p><strong>Điện trở tương đương:</strong></p>
                        <ul class="list-disc list-inside ml-4 space-y-1">
                            <li>Mắc nối tiếp: R = R₁ + R₂ + R₃ + ...</li>
                            <li>Mắc song song: 1/R = 1/R₁ + 1/R₂ + 1/R₃ + ...</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quiz Tab -->
        <div id="quiz-content" class="tab-content hidden">
            <div class="bg-white rounded-xl shadow-md p-6">
                <h2 class="text-2xl font-bold text-gray-800 mb-6">Kiểm Tra Kiến Thức</h2>
                <div id="quiz-container">
                    <div class="mb-6">
                        <div class="flex justify-between items-center mb-4">
                            <span class="text-lg font-medium">Câu <span id="question-number">1</span>/5</span>
                            <span class="text-sm text-gray-600">Điểm: <span id="quiz-score">0</span></span>
                        </div>
                        <div class="w-full bg-gray-200 rounded-full h-2 mb-4">
                            <div id="quiz-progress" class="bg-blue-500 h-2 rounded-full transition-all" style="width: 20%"></div>
                        </div>
                    </div>
                    
                    <div id="question-container">
                        <h3 id="question-text" class="text-xl font-medium mb-6">Đang tải câu hỏi...</h3>
                        <div id="options-container" class="space-y-3">
                            <!-- Options will be populated by JavaScript -->
                        </div>
                    </div>
                    
                    <div class="mt-6 flex justify-between">
                        <button id="prev-btn" onclick="previousQuestion()" class="px-6 py-2 bg-gray-300 text-gray-700 rounded-lg font-medium hover:bg-gray-400 transition-all" disabled>
                            ← Câu Trước
                        </button>
                        <button id="next-btn" onclick="nextQuestion()" class="px-6 py-2 bg-blue-500 text-white rounded-lg font-medium hover:bg-blue-600 transition-all">
                            Câu Tiếp →
                        </button>
                    </div>
                </div>
                
                <div id="quiz-result" class="hidden text-center">
                    <h3 class="text-2xl font-bold mb-4">Kết Quả Kiểm Tra</h3>
                    <div class="text-6xl mb-4">🎉</div>
                    <p class="text-xl mb-2">Bạn đã trả lời đúng <span id="final-score">0</span>/5 câu</p>
                    <p id="result-message" class="text-lg text-gray-600 mb-6"></p>
                    <button onclick="restartQuiz()" class="px-6 py-3 bg-blue-500 text-white rounded-lg font-medium hover:bg-blue-600 transition-all">
                        Làm Lại
                    </button>
                </div>
            </div>
        </div>

        <!-- Calculator Tab -->
        <div id="calculator-content" class="tab-content hidden">
            <div class="bg-white rounded-xl shadow-md p-6">
                <h2 class="text-2xl font-bold text-gray-800 mb-6">Máy Tính Vật Lý</h2>
                
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <!-- Kinematic Calculator -->
                    <div class="bg-gradient-to-br from-blue-50 to-blue-100 p-6 rounded-xl">
                        <h3 class="text-xl font-bold text-blue-700 mb-4">🚀 Tính Toán Chuyển Động</h3>
                        <div class="space-y-4">
                            <div>
                                <label for="velocity" class="block text-sm font-medium text-gray-700 mb-1">Vận tốc (m/s)</label>
                                <input type="number" id="velocity" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                            </div>
                            <div>
                                <label for="time" class="block text-sm font-medium text-gray-700 mb-1">Thời gian (s)</label>
                                <input type="number" id="time" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                            </div>
                            <button onclick="calculateDistance()" class="w-full bg-blue-500 text-white py-2 rounded-lg font-medium hover:bg-blue-600 transition-all">
                                Tính Quãng Đường
                            </button>
                            <div id="distance-result" class="p-3 bg-white rounded-lg border hidden">
                                <p class="font-medium">Kết quả:</p>
                                <p id="distance-value" class="text-lg text-blue-600"></p>
                            </div>
                        </div>
                    </div>

                    <!-- Power Calculator -->
                    <div class="bg-gradient-to-br from-green-50 to-green-100 p-6 rounded-xl">
                        <h3 class="text-xl font-bold text-green-700 mb-4">⚡ Tính Công Suất Điện</h3>
                        <div class="space-y-4">
                            <div>
                                <label for="voltage" class="block text-sm font-medium text-gray-700 mb-1">Hiệu điện thế (V)</label>
                                <input type="number" id="voltage" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500">
                            </div>
                            <div>
                                <label for="current" class="block text-sm font-medium text-gray-700 mb-1">Cường độ dòng điện (A)</label>
                                <input type="number" id="current" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500">
                            </div>
                            <button onclick="calculatePower()" class="w-full bg-green-500 text-white py-2 rounded-lg font-medium hover:bg-green-600 transition-all">
                                Tính Công Suất
                            </button>
                            <div id="power-result" class="p-3 bg-white rounded-lg border hidden">
                                <p class="font-medium">Kết quả:</p>
                                <p id="power-value" class="text-lg text-green-600"></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Add Formula Modal -->
    <div id="add-formula-modal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
        <div class="bg-white rounded-xl shadow-2xl p-6 w-full max-w-md mx-4">
            <div class="flex justify-between items-center mb-6">
                <h3 class="text-xl font-bold text-gray-800">Thêm Công Thức Mới</h3>
                <button onclick="hideAddFormulaModal()" class="text-gray-500 hover:text-gray-700 text-2xl">×</button>
            </div>
            
            <form id="add-formula-form" onsubmit="addNewFormula(event)" class="space-y-4">
                <div>
                    <label for="formula-title" class="block text-sm font-medium text-gray-700 mb-1">Tên công thức</label>
                    <input type="text" id="formula-title" required class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500" placeholder="Ví dụ: Định luật Newton II">
                </div>
                
                <div>
                    <label for="formula-equation" class="block text-sm font-medium text-gray-700 mb-1">Công thức</label>
                    <input type="text" id="formula-equation" required class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500" placeholder="Ví dụ: F = ma">
                </div>
                
                <div>
                    <label for="formula-category" class="block text-sm font-medium text-gray-700 mb-1">Chủ đề</label>
                    <select id="formula-category" required class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500">
                        <option value="">Chọn chủ đề</option>
                        <option value="mechanics">Cơ Học</option>
                        <option value="thermodynamics">Nhiệt Học</option>
                        <option value="electricity">Điện Học</option>
                        <option value="custom">Khác</option>
                    </select>
                </div>
                
                <div>
                    <label for="formula-description" class="block text-sm font-medium text-gray-700 mb-1">Mô tả</label>
                    <textarea id="formula-description" required rows="3" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500" placeholder="Giải thích ý nghĩa của công thức"></textarea>
                </div>
                
                <div>
                    <label for="formula-variables" class="block text-sm font-medium text-gray-700 mb-1">Ký hiệu và đơn vị</label>
                    <textarea id="formula-variables" required rows="2" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500" placeholder="Ví dụ: F: lực (N), m: khối lượng (kg), a: gia tốc (m/s²)"></textarea>
                </div>
                
                <div class="flex gap-3 pt-4">
                    <button type="button" onclick="hideAddFormulaModal()" class="flex-1 px-4 py-2 bg-gray-300 text-gray-700 rounded-lg font-medium hover:bg-gray-400 transition-all">
                        Hủy
                    </button>
                    <button type="submit" class="flex-1 px-4 py-2 bg-green-500 text-white rounded-lg font-medium hover:bg-green-600 transition-all">
                        Thêm Công Thức
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Data
        const formulas = [
            {
                id: 1,
                category: 'mechanics',
                title: 'Vận tốc trung bình',
                formula: 'v = s/t',
                description: 'Vận tốc bằng quãng đường chia cho thời gian',
                variables: 'v: vận tốc (m/s), s: quãng đường (m), t: thời gian (s)'
            },
            {
                id: 2,
                category: 'mechanics',
                title: 'Gia tốc',
                formula: 'a = Δv/Δt',
                description: 'Gia tốc bằng độ biến thiên vận tốc chia cho thời gian',
                variables: 'a: gia tốc (m/s²), Δv: độ biến thiên vận tốc (m/s), Δt: thời gian (s)'
            },
            {
                id: 3,
                category: 'mechanics',
                title: 'Chu kì dao động',
                formula: 'T = 2π√(l/g)',
                description: 'Chu kì dao động của con lắc đơn',
                variables: 'T: chu kì (s), l: chiều dài dây (m), g: gia tốc trọng trường (m/s²)'
            },
            {
                id: 4,
                category: 'thermodynamics',
                title: 'Nguyên lý I nhiệt động học',
                formula: 'ΔU = A + Q',
                description: 'Độ biến thiên nội năng bằng tổng công và nhiệt lượng',
                variables: 'ΔU: độ biến thiên nội năng (J), A: công (J), Q: nhiệt lượng (J)'
            },
            {
                id: 5,
                category: 'thermodynamics',
                title: 'Phương trình trạng thái khí lí tưởng',
                formula: 'pV = nRT',
                description: 'Mối quan hệ giữa áp suất, thể tích và nhiệt độ',
                variables: 'p: áp suất (Pa), V: thể tích (m³), n: số mol, R: hằng số khí, T: nhiệt độ (K)'
            },
            {
                id: 6,
                category: 'electricity',
                title: 'Định luật Ohm',
                formula: 'I = U/R',
                description: 'Cường độ dòng điện tỉ lệ thuận với hiệu điện thế',
                variables: 'I: cường độ dòng điện (A), U: hiệu điện thế (V), R: điện trở (Ω)'
            },
            {
                id: 7,
                category: 'electricity',
                title: 'Công suất điện',
                formula: 'P = UI',
                description: 'Công suất bằng tích hiệu điện thế và cường độ dòng điện',
                variables: 'P: công suất (W), U: hiệu điện thế (V), I: cường độ dòng điện (A)'
            },
            {
                id: 8,
                category: 'electricity',
                title: 'Điện trở mắc nối tiếp',
                formula: 'R = R₁ + R₂ + R₃',
                description: 'Điện trở tương đương khi mắc nối tiếp',
                variables: 'R: điện trở tương đương (Ω), R₁, R₂, R₃: các điện trở thành phần (Ω)'
            }
        ];

        const quizQuestions = [
            {
                question: 'Công thức tính vận tốc trung bình là gì?',
                options: ['v = s/t', 'v = s×t', 'v = t/s', 'v = s + t'],
                correct: 0
            },
            {
                question: 'Đơn vị của gia tốc là gì?',
                options: ['m/s', 'm/s²', 'm²/s', 's/m'],
                correct: 1
            },
            {
                question: 'Nguyên lý I nhiệt động học được biểu diễn bằng công thức nào?',
                options: ['ΔU = A - Q', 'ΔU = A + Q', 'ΔU = A × Q', 'ΔU = Q - A'],
                correct: 1
            },
            {
                question: 'Theo định luật Ohm, cường độ dòng điện được tính bằng?',
                options: ['I = U × R', 'I = U/R', 'I = R/U', 'I = U + R'],
                correct: 1
            },
            {
                question: 'Chu kì dao động của con lắc đơn phụ thuộc vào?',
                options: ['Khối lượng quả nặng', 'Biên độ dao động', 'Chiều dài dây treo', 'Tất cả các yếu tố trên'],
                correct: 2
            }
        ];

        // State
        let currentTab = 'formulas';
        let currentFilter = 'all';
        let currentQuestion = 0;
        let quizScore = 0;
        let answeredQuestions = [];
        let studiedFormulas = new Set();
        let customFormulas = JSON.parse(localStorage.getItem('customFormulas') || '[]');
        let nextFormulaId = Math.max(...formulas.map(f => f.id), ...customFormulas.map(f => f.id || 0)) + 1;

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            renderFormulas();
            loadQuestion();
            updateProgress();
        });

        // Tab Management
        function showTab(tabName) {
            // Hide all tabs
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.add('hidden');
            });
            
            // Remove active class from all tab buttons
            document.querySelectorAll('[id^="tab-"]').forEach(btn => {
                btn.classList.remove('tab-active');
                btn.classList.add('text-gray-600', 'hover:bg-gray-100');
            });
            
            // Show selected tab
            document.getElementById(tabName + '-content').classList.remove('hidden');
            
            // Add active class to selected tab button
            const activeBtn = document.getElementById('tab-' + tabName);
            activeBtn.classList.add('tab-active');
            activeBtn.classList.remove('text-gray-600', 'hover:bg-gray-100');
            
            currentTab = tabName;
        }

        // Formula Management
        function renderFormulas() {
            const grid = document.getElementById('formulas-grid');
            let allFormulas = [...formulas, ...customFormulas];
            
            const filteredFormulas = currentFilter === 'all' 
                ? allFormulas
                : currentFilter === 'custom'
                ? customFormulas
                : allFormulas.filter(f => f.category === currentFilter);
            
            grid.innerHTML = filteredFormulas.map(formula => `
                <div class="formula-card bg-white rounded-xl shadow-md p-6 border-l-4 ${formula.isCustom ? 'border-green-500' : 'border-blue-500'}">
                    <div class="flex justify-between items-start mb-3">
                        <div class="flex-1">
                            <h3 class="text-lg font-bold text-gray-800">${formula.title}</h3>
                            ${formula.isCustom ? '<span class="text-xs bg-green-100 text-green-700 px-2 py-1 rounded-full">Của tôi</span>' : ''}
                        </div>
                        <div class="flex gap-2">
                            <button onclick="markAsStudied(${formula.id})" class="text-sm px-3 py-1 rounded-full ${studiedFormulas.has(formula.id) ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-600'} hover:bg-green-200 transition-all">
                                ${studiedFormulas.has(formula.id) ? '✓ Đã học' : 'Đánh dấu'}
                            </button>
                            ${formula.isCustom ? `<button onclick="deleteFormula(${formula.id})" class="text-sm px-2 py-1 bg-red-100 text-red-600 rounded-full hover:bg-red-200 transition-all">🗑️</button>` : ''}
                        </div>
                    </div>
                    <div class="bg-gray-50 p-4 rounded-lg mb-4">
                        <code class="text-xl font-mono text-blue-600">${formula.formula}</code>
                    </div>
                    <p class="text-gray-700 mb-3">${formula.description}</p>
                    <div class="text-sm text-gray-600">
                        <strong>Trong đó:</strong> ${formula.variables}
                    </div>
                </div>
            `).join('');
        }

        function filterFormulas(category) {
            currentFilter = category;
            
            // Update filter buttons
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.classList.remove('bg-blue-500', 'text-white');
                btn.classList.add('bg-gray-200', 'text-gray-700');
            });
            
            event.target.classList.remove('bg-gray-200', 'text-gray-700');
            event.target.classList.add('bg-blue-500', 'text-white');
            
            renderFormulas();
        }

        function markAsStudied(formulaId) {
            if (studiedFormulas.has(formulaId)) {
                studiedFormulas.delete(formulaId);
            } else {
                studiedFormulas.add(formulaId);
            }
            renderFormulas();
            updateProgress();
        }

        // Quiz Management
        function loadQuestion() {
            if (currentQuestion >= quizQuestions.length) {
                showQuizResult();
                return;
            }
            
            const question = quizQuestions[currentQuestion];
            document.getElementById('question-number').textContent = currentQuestion + 1;
            document.getElementById('question-text').textContent = question.question;
            document.getElementById('quiz-progress').style.width = ((currentQuestion + 1) / quizQuestions.length * 100) + '%';
            
            const optionsContainer = document.getElementById('options-container');
            optionsContainer.innerHTML = question.options.map((option, index) => `
                <button onclick="selectAnswer(${index})" class="quiz-option w-full text-left p-4 border-2 border-gray-200 rounded-lg hover:border-blue-300 transition-all">
                    <span class="font-medium">${String.fromCharCode(65 + index)}.</span> ${option}
                </button>
            `).join('');
            
            // Update navigation buttons
            document.getElementById('prev-btn').disabled = currentQuestion === 0;
            document.getElementById('next-btn').textContent = currentQuestion === quizQuestions.length - 1 ? 'Kết Thúc' : 'Câu Tiếp →';
        }

        function selectAnswer(selectedIndex) {
            const question = quizQuestions[currentQuestion];
            const options = document.querySelectorAll('.quiz-option');
            
            // Remove previous selections
            options.forEach(option => {
                option.classList.remove('quiz-correct', 'quiz-incorrect');
            });
            
            // Mark correct and incorrect answers
            options[question.correct].classList.add('quiz-correct');
            if (selectedIndex !== question.correct) {
                options[selectedIndex].classList.add('quiz-incorrect');
            }
            
            // Update score
            if (selectedIndex === question.correct && !answeredQuestions[currentQuestion]) {
                quizScore++;
                document.getElementById('quiz-score').textContent = quizScore;
            }
            
            answeredQuestions[currentQuestion] = selectedIndex;
            
            // Auto advance after 1.5 seconds
            setTimeout(() => {
                nextQuestion();
            }, 1500);
        }

        function nextQuestion() {
            currentQuestion++;
            loadQuestion();
        }

        function previousQuestion() {
            if (currentQuestion > 0) {
                currentQuestion--;
                loadQuestion();
            }
        }

        function showQuizResult() {
            document.getElementById('quiz-container').classList.add('hidden');
            document.getElementById('quiz-result').classList.remove('hidden');
            document.getElementById('final-score').textContent = quizScore;
            
            let message = '';
            const percentage = (quizScore / quizQuestions.length) * 100;
            
            if (percentage >= 80) {
                message = 'Xuất sắc! Bạn đã nắm vững kiến thức Vật lý.';
            } else if (percentage >= 60) {
                message = 'Khá tốt! Hãy ôn tập thêm một số phần.';
            } else {
                message = 'Cần cố gắng hơn! Hãy xem lại lý thuyết và công thức.';
            }
            
            document.getElementById('result-message').textContent = message;
        }

        function restartQuiz() {
            currentQuestion = 0;
            quizScore = 0;
            answeredQuestions = [];
            document.getElementById('quiz-score').textContent = '0';
            document.getElementById('quiz-container').classList.remove('hidden');
            document.getElementById('quiz-result').classList.add('hidden');
            loadQuestion();
        }

        // Calculator Functions
        function calculateDistance() {
            const velocity = parseFloat(document.getElementById('velocity').value);
            const time = parseFloat(document.getElementById('time').value);
            
            if (isNaN(velocity) || isNaN(time)) {
                alert('Vui lòng nhập đầy đủ các giá trị!');
                return;
            }
            
            const distance = velocity * time;
            document.getElementById('distance-result').classList.remove('hidden');
            document.getElementById('distance-value').textContent = `Quãng đường: ${distance} m`;
        }

        function calculatePower() {
            const voltage = parseFloat(document.getElementById('voltage').value);
            const current = parseFloat(document.getElementById('current').value);
            
            if (isNaN(voltage) || isNaN(current)) {
                alert('Vui lòng nhập đầy đủ các giá trị!');
                return;
            }
            
            const power = voltage * current;
            document.getElementById('power-result').classList.remove('hidden');
            document.getElementById('power-value').textContent = `Công suất: ${power} W`;
        }

        // Progress Management
        function updateProgress() {
            const totalFormulas = formulas.length + customFormulas.length;
            const studiedCount = studiedFormulas.size;
            const percentage = totalFormulas > 0 ? Math.round((studiedCount / totalFormulas) * 100) : 0;
            
            document.getElementById('progressBar').style.width = percentage + '%';
            document.getElementById('progressText').textContent = percentage + '%';
        }

        // Modal Management
        function showAddFormulaModal() {
            document.getElementById('add-formula-modal').classList.remove('hidden');
        }

        function hideAddFormulaModal() {
            document.getElementById('add-formula-modal').classList.add('hidden');
            document.getElementById('add-formula-form').reset();
        }

        // Add New Formula
        function addNewFormula(event) {
            event.preventDefault();
            
            const title = document.getElementById('formula-title').value.trim();
            const equation = document.getElementById('formula-equation').value.trim();
            const category = document.getElementById('formula-category').value;
            const description = document.getElementById('formula-description').value.trim();
            const variables = document.getElementById('formula-variables').value.trim();
            
            if (!title || !equation || !category || !description || !variables) {
                showNotification('Vui lòng điền đầy đủ thông tin!', 'error');
                return;
            }
            
            const newFormula = {
                id: nextFormulaId++,
                category: category,
                title: title,
                formula: equation,
                description: description,
                variables: variables,
                isCustom: true
            };
            
            customFormulas.push(newFormula);
            localStorage.setItem('customFormulas', JSON.stringify(customFormulas));
            
            hideAddFormulaModal();
            renderFormulas();
            updateProgress();
            showNotification('Đã thêm công thức mới thành công!', 'success');
        }

        // Delete Formula
        function deleteFormula(formulaId) {
            if (showConfirmDialog('Bạn có chắc muốn xóa công thức này?')) {
                customFormulas = customFormulas.filter(f => f.id !== formulaId);
                localStorage.setItem('customFormulas', JSON.stringify(customFormulas));
                studiedFormulas.delete(formulaId);
                renderFormulas();
                updateProgress();
                showNotification('Đã xóa công thức thành công!', 'success');
            }
        }

        // Notification System
        function showNotification(message, type = 'info') {
            const notification = document.createElement('div');
            notification.className = `fixed top-4 right-4 z-50 px-6 py-3 rounded-lg shadow-lg text-white font-medium transition-all transform translate-x-full`;
            notification.className += type === 'success' ? ' bg-green-500' : type === 'error' ? ' bg-red-500' : ' bg-blue-500';
            notification.textContent = message;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.classList.remove('translate-x-full');
            }, 100);
            
            setTimeout(() => {
                notification.classList.add('translate-x-full');
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 300);
            }, 3000);
        }

        // Confirm Dialog
        function showConfirmDialog(message) {
            const modal = document.createElement('div');
            modal.className = 'fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50';
            modal.innerHTML = `
                <div class="bg-white rounded-xl shadow-2xl p-6 w-full max-w-sm mx-4">
                    <h3 class="text-lg font-bold text-gray-800 mb-4">Xác nhận</h3>
                    <p class="text-gray-600 mb-6">${message}</p>
                    <div class="flex gap-3">
                        <button onclick="this.closest('.fixed').remove(); window.confirmResult = false;" class="flex-1 px-4 py-2 bg-gray-300 text-gray-700 rounded-lg font-medium hover:bg-gray-400 transition-all">
                            Hủy
                        </button>
                        <button onclick="this.closest('.fixed').remove(); window.confirmResult = true;" class="flex-1 px-4 py-2 bg-red-500 text-white rounded-lg font-medium hover:bg-red-600 transition-all">
                            Xóa
                        </button>
                    </div>
                </div>
            `;
            
            document.body.appendChild(modal);
            
            return new Promise((resolve) => {
                const checkResult = () => {
                    if (window.confirmResult !== undefined) {
                        const result = window.confirmResult;
                        window.confirmResult = undefined;
                        resolve(result);
                    } else {
                        setTimeout(checkResult, 100);
                    }
                };
                checkResult();
            });
        }
    </script>
<script>(function(){function c(){var b=a.contentDocument||a.contentWindow.document;if(b){var d=b.createElement('script');d.innerHTML="window.__CF$cv$params={r:'994210a427ce9626',t:'MTc2MTM5ODk4OS4wMDAwMDA='};var a=document.createElement('script');a.nonce='';a.src='/cdn-cgi/challenge-platform/scripts/jsd/main.js';document.getElementsByTagName('head')[0].appendChild(a);";b.getElementsByTagName('head')[0].appendChild(d)}}if(document.body){var a=document.createElement('iframe');a.height=1;a.width=1;a.style.position='absolute';a.style.top=0;a.style.left=0;a.style.border='none';a.style.visibility='hidden';document.body.appendChild(a);if('loading'!==document.readyState)c();else if(window.addEventListener)document.addEventListener('DOMContentLoaded',c);else{var e=document.onreadystatechange||function(){};document.onreadystatechange=function(b){e(b);'loading'!==document.readyState&&(document.onreadystatechange=e,c())}}}})();</script></body>
</html>
